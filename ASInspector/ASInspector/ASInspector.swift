//
//  Inspector.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

public class ASInspector {
  public static let shared = ASInspector()
  private let networkManager: NetworkManager
  private let uiManager: UIManager
  private var _isEnabled: Bool
  
  init(
    networkManager: NetworkManager = .shared,
    uiManager: UIManager = .shared
  ) {
    self.networkManager = networkManager
    self.uiManager = uiManager
    self._isEnabled = false
  }
}

// MARK: - Public Helpers
public extension ASInspector {
  var isEnable: Bool {
    get { _isEnabled }
    set {
      _isEnabled = newValue
      newValue ? enableLogger() : disableLogger()
    }
  }
  
  func clearAll() {
    networkManager.clearAll()
  }
}

// MARK: - Private Helpers
private extension ASInspector {
  func enableLogger() {
    networkManager.startLogging()
    let deadline: DispatchTime = .now() + 1
    DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
      self?.uiManager.addLoggerButton()
    }
  }
  
  func disableLogger() {
    networkManager.stopLogging()
    uiManager.removeWindows()
  }
}
