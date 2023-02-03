//
//  Array+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation

public extension Array {
  /// Variable that returns empty Array
  static var empty: [Element] {
    []
  }
  /// Variable that returns if Array is empty or not
  var isNotEmpty: Bool {
    return !isEmpty
  }
  
  /// Subscript to avoid out of bounds crashes
  subscript(safe index: Index) -> Element? {
    isValid(index: index) ? self[index] : nil
  }
  
  /// safe set element in array at index
  /// - Parameters:
  ///   - value: New elemant value
  ///   - index: array index
  mutating func safeSet(_ value: Element, at index: Int) {
    guard isValid(index: index) else { return }
    self[index] = value
  }
  
  /// Index is in array or out of Array
  /// - Parameter index: array index
  /// - Returns: is valid index
  func isValid(index: Int) -> Bool {
    index >= 0 && index < count
  }
}

extension Array where Element: Hashable {
  var distinct: Array {
    var buffer = Array()
    var added = Set<Element>()
    for element in self {
      if !added.contains(element) {
        buffer.append(element)
        added.insert(element)
      }
    }
    return buffer
  }
}
