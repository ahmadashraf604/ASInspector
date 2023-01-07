//
//  Data+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import struct Foundation.Data

#if os(Linux)
    import zlibLinux
#else
    import zlib
#endif

extension Data {
  /// Whether the receiver is compressed in gzip format.
  public var isGzipped: Bool {
      return self.starts(with: [0x1f, 0x8b])  // check magic number
  }
  
  func sniffMimeEnum() -> FileMeta {
    var magicNumbers = [UInt8](repeating: 0, count: MIMEChecker.maxDataNeed)
    copyBytes(to: &magicNumbers, count: MIMEChecker.maxDataNeed)
    return AppUtilities.shared.getFileMeta(from: magicNumbers)
  }
  
  func hexEncodedString() -> String {
    return map { String(format: "%02hhx", $0) }.joined()
  }
  
  /// Create a new `Data` instance by decompressing the receiver using zlib.
  /// Throws an error if decompression failed.
  ///
  /// - Returns: Gzip-decompressed `Data` instance.
  /// - Throws: `GzipError`
  public func gunzipped() throws -> Data {
      
      guard !self.isEmpty else {
          return Data()
      }

      var stream = z_stream()
      var status: Int32
      
      status = inflateInit2_(&stream, MAX_WBITS + 32, ZLIB_VERSION, Int32(DataSize.stream))
      
      guard status == Z_OK else {
          // inflateInit2 returns:
          // Z_VERSION_ERROR   The zlib library version is incompatible with the version assumed by the caller.
          // Z_MEM_ERROR       There was not enough memory.
          // Z_STREAM_ERROR    A parameters are invalid.
          
          throw GzipError(code: status, msg: stream.msg)
      }
      
      var data = Data(capacity: self.count * 2)
      repeat {
          if Int(stream.total_out) >= data.count {
              data.count += self.count / 2
          }
          
          let inputCount = self.count
          let outputCount = data.count
          
          self.withUnsafeBytes { (inputPointer: UnsafeRawBufferPointer) in
              stream.next_in = UnsafeMutablePointer<Bytef>(mutating: inputPointer.bindMemory(to: Bytef.self).baseAddress!).advanced(by: Int(stream.total_in))
              stream.avail_in = uint(inputCount) - uInt(stream.total_in)
              
              data.withUnsafeMutableBytes { (outputPointer: UnsafeMutableRawBufferPointer) in
                  stream.next_out = outputPointer.bindMemory(to: Bytef.self).baseAddress!.advanced(by: Int(stream.total_out))
                  stream.avail_out = uInt(outputCount) - uInt(stream.total_out)
                  
                  status = inflate(&stream, Z_SYNC_FLUSH)
                  
                  stream.next_out = nil
              }
              
              stream.next_in = nil
          }
          
      } while status == Z_OK
      
      guard inflateEnd(&stream) == Z_OK, status == Z_STREAM_END else {
          // inflate returns:
          // Z_DATA_ERROR   The input data was corrupted (input stream not conforming to the zlib format or incorrect check value).
          // Z_STREAM_ERROR The stream structure was inconsistent (for example if next_in or next_out was NULL).
          // Z_MEM_ERROR    There was not enough memory.
          // Z_BUF_ERROR    No progress is possible or there was not enough room in the output buffer when Z_FINISH is used.
          
          throw GzipError(code: status, msg: stream.msg)
      }
      
      data.count = Int(stream.total_out)
      
      return data
  }
}
