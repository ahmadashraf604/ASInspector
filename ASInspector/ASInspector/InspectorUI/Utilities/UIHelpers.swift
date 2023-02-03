//
//  UIHelpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

class UIHelpers {
  static let shared = UIHelpers()
  
  var defaultBounds: CGRect {
    UIScreen.main.bounds
  }
  
  var statusBarHeight: CGFloat {
    statusBarFrame?.height ?? .zero
  }
  
  var statusBarFrame: CGRect? {
    if #available(iOS 13.0, *) {
      return keyWindow?.windowScene?.statusBarManager?.statusBarFrame
    } else {
      return UIApplication.shared.statusBarFrame
    }
  }
  
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
  
  // Return current root view controller
  var presentingViewController: UIViewController? {
      var rootViewController = keyWindow?.rootViewController
      while let controller = rootViewController?.presentedViewController {
          rootViewController = controller
      }
      return rootViewController
  }
  
  func getNavigationButton(image: UIImage?, imageInsets: UIEdgeInsets = UIEdgeInsets(top: 15, left: 25, bottom: 9, right: 5)) -> UIButton {
    let customButton = UIButton()
    customButton.tintColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
    customButton.imageView?.contentMode = .scaleAspectFit
//    customButton.imageEdgeInsets = imageInsets
    customButton.setImage(image, for: .normal)
    return customButton
  }
}
