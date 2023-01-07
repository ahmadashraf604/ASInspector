//
//  URLSessionConfiguration+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

extension URLSessionConfiguration {
  
  /// Never call this method directly.  Always use `protocolClasses` to get protocol classes.
  @objc func getProcotolClasses() -> [AnyClass]? {
    guard let procotolClasses = self.getProcotolClasses() else {
      return []
    }
    var originalProtocolClasses = procotolClasses.filter { $0 != ASURLProtocol.self }
    // Make sure XNURLProtocol class is at top in protocol classes list.
    originalProtocolClasses.insert(ASURLProtocol.self, at: 0)
    return originalProtocolClasses
  }
}
