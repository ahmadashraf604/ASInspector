//
//  UIHelpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

class UIHelpers {
  static let shared = UIHelpers()
  
  var windowScenes: [UIWindowScene] {
    let windowScenes = UIApplication.shared.connectedScenes
      .filter { $0.activationState == .foregroundActive }
      .compactMap { $0 as? UIWindowScene }
    return windowScenes
  }
  
  var windowScene: UIWindowScene? {
    windowScenes.first
  }
  
  var appWindows: [UIWindow] {
    if #available(iOS 13.0, *) {
      return windowScenes.flatMap({ $0.windows })
    } else {
      return UIApplication.shared.windows
    }
  }
  
  var ourWindow: UIWindow? {
    appWindows.first(where: { $0.isKind(of: BaseWindow.self) })
  }
  
  var keyWindow: UIWindow? {
    appWindows.first { $0.isKeyWindow }
  }
}
