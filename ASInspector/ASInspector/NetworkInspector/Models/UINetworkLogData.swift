//
//  UINetworkLogData.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

class UINetworkLogData {
  var identifier: String
  var title: String?
  var state: SessionState?
  var statusCode: Int?
  var httpMethod: String?
  var duration: String?
  var startTime: Date?
  
  init(identifier: String) {
    self.identifier = identifier
  }
  
  convenience init(from logData: NetworkLogData) {
    self.init(identifier: logData.identifier)
    if let scheme = logData.urlRequest.url?.scheme,
       let host = logData.urlRequest.url?.host, let path = logData.urlRequest.url?.path {
      self.title = "\(scheme)://\(host)\(path)"
    } else {
      self.title = logData.urlRequest.url?.absoluteString ?? "No URL found"
    }
    self.httpMethod = logData.urlRequest.httpMethod
    self.startTime = logData.startTime
    self.duration = logData.getDurationString()
    self.state = logData.state
    if let httpResponse = logData.response as? HTTPURLResponse {
      self.statusCode = httpResponse.statusCode
    }
  }
}
