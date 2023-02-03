//
//  UIView+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

extension UIView {
  var cornarRadias: CGFloat {
    get { layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  func setCircleCorner() {
    cornarRadias = frame.height / 2
  }
  
  /// Add constraints to current view to match with given another view with specified margin.
  /// Another view can be parent or child of current view.
  /// - Parameters:
  ///   - view: View to match current view.
  ///   - margin: Margin between current view and the other view
  func match(to view: UIView, margin: CGFloat = .zero) {
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
      trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: margin),
      topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
      bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: margin)
    ])
  }
}
