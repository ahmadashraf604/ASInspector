//
//  SessionState.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

public enum SessionState: Int {
  case running
  case suspended
  case canceling
  case completed
  case unknown
  
  var name: String {
    switch self {
    case .running:
      return "Running..."
    case .suspended:
      return "Suspended"
    case .canceling:
      return "Canceling"
    case .completed:
      return "Completed"
    case .unknown:
      return "Unknown"
    }
  }
}
