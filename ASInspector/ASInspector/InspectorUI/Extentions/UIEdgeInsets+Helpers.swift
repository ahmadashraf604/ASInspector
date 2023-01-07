//
//  UIEdgeInsets+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

extension UIEdgeInsets {
  
  init(inset: CGFloat) {
    self.init(top: inset, left: inset, bottom: inset, right: inset)
  }
}

// MARK: - NSDirectionalEdgeInsets
extension NSDirectionalEdgeInsets {
  
  init(inset: CGFloat) {
    self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
  }
  
  init(insets: UIEdgeInsets) {
    self.init(
      top: insets.top,
      leading: insets.left,
      bottom: insets.bottom,
      trailing: insets.right
    )
  }
}
