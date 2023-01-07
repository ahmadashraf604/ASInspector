//
//  GzipError.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

import struct Foundation.Data

#if os(Linux)
import zlibLinux
#else
import zlib
#endif

/// Errors on gzipping/gunzipping based on the zlib error codes.
public struct GzipError: Swift.Error {
  // cf. http://www.zlib.net/manual.html
  
  public enum Kind: Equatable {
    /// The stream structure was inconsistent.
    ///
    /// - underlying zlib error: `Z_STREAM_ERROR` (-2)
    case stream
    
    /// The input data was corrupted
    /// (input stream not conforming to the zlib format or incorrect check value).
    ///
    /// - underlying zlib error: `Z_DATA_ERROR` (-3)
    case data
    
    /// There was not enough memory.
    ///
    /// - underlying zlib error: `Z_MEM_ERROR` (-4)
    case memory
    
    /// No progress is possible or there was not enough room in the output buffer.
    ///
    /// - underlying zlib error: `Z_BUF_ERROR` (-5)
    case buffer
    
    /// The zlib library version is incompatible with the version assumed by the caller.
    ///
    /// - underlying zlib error: `Z_VERSION_ERROR` (-6)
    case version
    
    /// An unknown error occurred.
    ///
    /// - parameter code: return error by zlib
    case unknown(code: Int)
  }
  
  /// Error kind.
  public let kind: Kind
  
  /// Returned message by zlib.
  public let message: String
  
  
  internal init(code: Int32, msg: UnsafePointer<CChar>?) {
    
    self.message = {
      guard let msg = msg, let message = String(validatingUTF8: msg) else {
        return "Unknown gzip error"
      }
      return message
    }()
    
    self.kind = {
      switch code {
      case Z_STREAM_ERROR:
        return .stream
      case Z_DATA_ERROR:
        return .data
      case Z_MEM_ERROR:
        return .memory
      case Z_BUF_ERROR:
        return .buffer
      case Z_VERSION_ERROR:
        return .version
      default:
        return .unknown(code: Int(code))
      }
    }()
  }
  
  
  public var localizedDescription: String {
    
    return self.message
  }
  
}
