//
//  NSMutableURLRequest+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

extension NSMutableURLRequest {
  
  func setNLFlag(value: Any) {
    URLProtocol.setProperty(value, forKey: kRequestFlagKey, in: self)
  }
}
