//
//  NetworkInterceptor.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

internal class NetworkInterceptor: NSObject {
  
  /// Setup and start logging network calls.
  func startInterceptingNetwork() {
    /// Before swizzle checking if it's already not swizzled.
    /// If it already swizzled skip else swizzle for logging.
    /// This check make safe to call multiple times.
    guard !isProtocolSwizzled() else { return }
    
    // Let cache URLSession protocol classes without Custom log URL protocol class.
    // So that later custom URL protocol can be disabled
    _ = URLSession.shared
    swizzleProtocolClasses()
  }
  
  /**
   Stop intercepting network calls and revert back changes made to
   intercept network calls.
   */
  func stopInterceptingNetwork() {
    /// Check if already unswizzled for logging, if so then skip
    /// else unswizzle for logging i.e. it will stop logging.
    /// Check make it safe to call multiple times.
    if isProtocolSwizzled() {
      swizzleProtocolClasses()
    }
  }
  
  func isProtocolSwizzled() -> Bool {
    let protocolClasses: [AnyClass] = URLSessionConfiguration.default.protocolClasses ?? []
    for protocolCls in protocolClasses {
      if protocolCls == ASURLProtocol.self {
        return true
      }
    }
    return false
  }
  
  func swizzleProtocolClasses() {
    let instance = URLSessionConfiguration.default
    if let uRLSessionConfigurationClass: AnyClass = object_getClass(instance),
       let originalProtocolGetter: Method = class_getInstanceMethod(uRLSessionConfigurationClass, #selector(getter: uRLSessionConfigurationClass.protocolClasses)),
       let customProtocolClass: Method = class_getInstanceMethod(URLSessionConfiguration.self, #selector(URLSessionConfiguration.getProcotolClasses)) {
      method_exchangeImplementations(originalProtocolGetter, customProtocolClass)
    } else {
      print("Failed to swizzle protocol classes")
    }
  }
  
}

