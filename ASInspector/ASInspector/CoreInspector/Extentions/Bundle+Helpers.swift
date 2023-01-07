//
//  Bundle+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

extension Bundle {
  static var current: Bundle {
    class __ {}
    return Bundle(for: __.self)
  }
}
