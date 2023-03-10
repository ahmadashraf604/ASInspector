//
//  UIButton+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

extension UIButton {
  func setInsets(
    forContentPadding contentPadding: UIEdgeInsets,
    imageTitlePadding: CGFloat = .zero
  ) {
    if configuration != nil {
      configuration?.contentInsets = NSDirectionalEdgeInsets(insets: contentPadding)
    } else {
      contentEdgeInsets = UIEdgeInsets(
        top: contentPadding.top,
        left: contentPadding.left,
        bottom: contentPadding.bottom,
        right: contentPadding.right + imageTitlePadding
      )
      titleEdgeInsets = UIEdgeInsets(
        top: 0,
        left: imageTitlePadding,
        bottom: 0,
        right: -imageTitlePadding
      )
    }
  }
}
