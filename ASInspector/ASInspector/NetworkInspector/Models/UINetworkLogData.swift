//
//  UINetworkLogData.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

class UINetworkLogData {
  var identifier: String
  var url: String?
  var state: SessionState?
  var statusCode: Int?
  var method: String?
  var duration: String?
  var startTime: Date?
  
  init(identifier: String) {
    self.identifier = identifier
  }
  
  convenience init(from logData: NetworkLogData) {
    self.init(identifier: logData.identifier)
    if let scheme = logData.urlRequest.url?.scheme,
       let host = logData.urlRequest.url?.host, let path = logData.urlRequest.url?.path {
      self.url = "\(scheme)://\(host)\(path)"
    } else {
      self.url = logData.urlRequest.url?.absoluteString ?? "No URL found"
    }
    self.method = logData.urlRequest.httpMethod
    self.startTime = logData.startTime
    self.duration = logData.getDurationString()
    self.state = logData.state
    if let httpResponse = logData.response as? HTTPURLResponse {
      self.statusCode = httpResponse.statusCode
    }
  }
}

// MARK: - UINetworkLogData + NetworkRepresentable
extension UINetworkLogData: NetworkRepresentable {
  var status: String? {
    statusCode?.toString
  }
  
  var date: String? {
    startTime?.toString(with: .time)
  }
}
