//
//  AppUtilities.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

class AppUtilities {
  
  static let shared = AppUtilities()
  static private var logIdentifier: UInt64 = 0
  lazy var mimeChecker: MIMEChecker = {
    return MIMEChecker()
  }()
  
  private init() {}
  
  /**
   Create URLRequest which skip Network Logger
   */
  func createNLRequest(_ request: URLRequest) -> URLRequest? {
    let mutableURLRequest = request.getNSMutableURLRequest()
    mutableURLRequest?.setNLFlag(value: true)
    if let urlRequest = mutableURLRequest {
      return urlRequest as URLRequest
    } else {
      return nil
    }
  }
  
  func getFileMeta(from dataBytes: [UInt8]) -> FileMeta {
    return mimeChecker.getFileMeta(from: dataBytes)
  }
  
  func getFileMeta(from mimeString: String?) -> FileMeta {
    return mimeChecker.getFileMeta(from: mimeString)
  }
  
  func isContentTypeReadable(_ contentType: ContentType) -> Bool {
    switch contentType {
    case .json, .text, .urlencoded:
      return true
    default:
      return false
    }
  }
}
