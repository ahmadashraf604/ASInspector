//
//  DispatchQueue+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

extension DispatchQueue {
  func safeAsync(_ block: @escaping ()->()) {
    if self === DispatchQueue.main && Thread.isMainThread {
      block()
    } else {
      async { block() }
    }
  }
}
