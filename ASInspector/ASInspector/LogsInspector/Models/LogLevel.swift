//
//  LogLevel.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 18/03/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation

public enum LogLevel: String {
  case error
  case warning
  case info
  case debug
  
  var printValue: String {
    switch self {
    case .error: return "🚨  error  🚨"
    case .warning: return "⚠️  warning  ⚠️"
    case .info: return "ℹ️  info  ℹ️"
    case .debug: return "🔍  debug  🔍"
    }
  }
}
