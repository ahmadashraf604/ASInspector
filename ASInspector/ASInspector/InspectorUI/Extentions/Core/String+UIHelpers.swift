//
//  String+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

extension String {
  
  public func heightWithConstrainedWidth(
    _ width: CGFloat, font: UIFont,
    options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
  ) -> CGSize {
    let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
    return boundingBox.size
  }
  
  public func widthWithConstrainedHeight(
    _ height: CGFloat, font: UIFont,
    options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
  ) -> CGSize {
    let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
    return boundingBox.size
  }
  
}
