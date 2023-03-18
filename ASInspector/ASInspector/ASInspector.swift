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
  private var _logInConsole: Bool
  
  init(
    networkManager: NetworkManager = .shared,
    uiManager: UIManager = .shared
  ) {
    self.networkManager = networkManager
    self.uiManager = uiManager
    self._isEnabled = false
    self._logInConsole = false
  }
}

// MARK: - Public Helpers
public extension ASInspector {
  /// Enable and Disable logs
  var isEnable: Bool {
    get { _isEnabled }
    set {
      _isEnabled = newValue
      newValue ? enableLogger() : disableLogger()
    }
  }
  /// Enable and Disable Console Logging
  var shouldLogInConsole: Bool {
    get { _logInConsole }
    set {
      _logInConsole = newValue
    }
  }
  
  func clearAll() {
    networkManager.clearAll()
  }
  
  func log(with level: LogLevel = .debug, _ logData: String...,
           file: String = #file,
           function: String = #function,
           line: Int = #line
           
  ) {
    let filename = URL(fileURLWithPath: file).lastPathComponent
    let log = LogData(
      creationDate: Date(),
      filename: filename,
      function: function,
      line: line,
      log: logData.joined(separator: ", "),
      level: level
    )
    LoggerManager.shared.save(log)
    if (_logInConsole) {
      Swift.print(log.description)
    }
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
