//
//  Logger.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 18/03/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation
import CoreData

extension LogEntity {
  
  ///  Entity name in Core Data
  static var entityName: String {
    "LogEntity"
  }
  
  /// Create date Column name in Core Data
  static var creationDateKey: String {
    "creationDate"
  }
  
  /// Get `LogData` Data from `LogEntity`
  /// - Returns: LogData Created from self
  func getData() -> LogData {
    LogData(
      creationDate: creationDate ?? Date(),
      filename: filename ?? "",
      function: function ?? "",
      line: Int(line),
      log: log ?? "",
      level: LogLevel(rawValue: logLevel ?? "") ?? LogLevel.debug
    )
  }
  
  /// Set `LogData` Data in `LogEntity`
  /// - Parameter data: data will used to convert
  func setData(_ data: LogData) {
    self.creationDate = data.creationDate
    self.logLevel = data.level.rawValue
    self.filename = data.filename
    self.function = data.function
    self.log = data.log
    self.line = Int16(data.line)
  }
}
