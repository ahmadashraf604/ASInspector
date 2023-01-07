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
  private var isEnabled: Bool
  
  init(
    networkManager: NetworkManager = .shared
  ) {
    self.networkManager = networkManager
    isEnabled = false
  }
}

// MARK: - Public Helpers
public extension ASInspector {
  
  func setEnable(_ enable: Bool) {
    self.isEnabled = enable
    enable ? enableLogger() : disableLogger()
  }
  
  func clearAll() {
    networkManager.clearAll()
  }
}

// MARK: - Private Helpers
private extension ASInspector {
  func enableLogger() {
    networkManager.startLogging()
  }
  
  func disableLogger() {
    networkManager.stopLogging()
  }
}
