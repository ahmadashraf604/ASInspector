//
//  UIManager.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

public class UIManager {
  public static let shared = UIManager()
  var isMiniModeActive: Bool = false
  private var iconWindow: BaseWindow?
  private var logWindow: BaseWindow?
  private var uiHelper: UIHelpers
  
  init(
    uiHelper: UIHelpers = .shared
  ) {
    self.uiHelper = uiHelper
  }
}

// MARK: - Public Helpers
public extension UIManager {
  
  func addLoggerButton() {
    iconWindow = IconWindow()
    iconWindow?.makeKeyAndVisible()
  }
  
  func removeWindows() {
    iconWindow = nil
  }
  
  func presentUI() {
    guard let rootViewController = uiHelper.presentingViewController,
    !rootViewController.isKind(of: UIBaseTabBarController.self)
    else { return }
    let viewController = UIBaseTabBarController()
    viewController.modalPresentationStyle = .overFullScreen
    logWindow = BaseWindow()
    logWindow?.frame = uiHelper.defaultBounds
    logWindow?.present(rootVC: viewController)
  }
  
  func dismissUI() {
    logWindow?.dismiss(completion: {
      self.logWindow = nil
      self.isMiniModeActive = false
    })
 }
}

// MARK: - Priavte Helpers
private extension UIManager {
  
}
