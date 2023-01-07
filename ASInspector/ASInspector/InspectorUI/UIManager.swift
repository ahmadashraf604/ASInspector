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
  private var mainWindow: BaseWindow?
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
    mainWindow = IconWindow()
    mainWindow?.makeKeyAndVisible()
  }
  
  func removeWindows() {
    mainWindow = nil
  }
}
