//
//  URLRequest+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

extension URLRequest {
  
  func getNSMutableURLRequest() -> NSMutableURLRequest? {
    guard let mutableRequest = (self as NSURLRequest).mutableCopy() as? NSMutableURLRequest
    else { return nil }
    return mutableRequest
  }
  
  func getHttpBodyStreamData() -> Data? {
    guard let httpBodyStream = self.httpBodyStream else {
      return nil
    }
    
    var data = Data()
    var buffer = [UInt8](repeating: 0, count: 4096)
    
    httpBodyStream.open()
    while httpBodyStream.hasBytesAvailable {
      let length = httpBodyStream.read(&buffer, maxLength: 4096)
      if length == 0 {
        break
      } else {
        data.append(buffer, count: length)
      }
    }
    httpBodyStream.close()
    if data.isGzipped {
      do {
        return try data.gunzipped()
      } catch let error as NSError {
        print("[ASLogger] error: \(error.localizedDescription)")
      }
    }
    return data
  }
  
  func getMimeType() -> String? {
    let contType: String? = value(forHTTPHeaderField: "Content-Type")
    if let contentType = contType, contentType.isEmpty == false {
      let components = contentType.split(separator: ";")
      if components.count > 0 {
        let mimeType = components[0].replacingOccurrences(of: ";", with: "")
        return mimeType
      } else {
        return nil
      }
    } else {
      return nil
    }
  }
  
  func sniffMimeEnum() -> FileMeta {
    if let data = httpBody, data.isEmpty == false {
      return data.sniffMimeEnum()
    }
    else if let data = getHttpBodyStreamData() {
      return data.sniffMimeEnum()
    }
    else {
      return FileMeta(ext: nil, mime: nil, contentType: .unknown(nil))
    }
  }
}
