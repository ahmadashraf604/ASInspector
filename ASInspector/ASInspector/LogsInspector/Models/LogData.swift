//
//  LogData.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 18/03/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation

public struct LogData {
  let creationDate: Date
  let filename: String
  let function: String
  let line: Int
  let log: String
  let level: LogLevel
  
  init(
    creationDate: Date,
    filename: String,
    function: String,
    line: Int,
    log: String,
    level: LogLevel
  ) {
    self.creationDate = creationDate
    self.filename = filename
    self.function = function
    self.line = line
    self.log = log
    self.level = level
  }
  
  var description: String {
    """
    \(level.printValue)
        date: \(creationDate.toString(with: .date)) \t time: \(creationDate.toString(with: .time))
        line: \(line)
        function: \(function)
        file: \(filename)
        log: \(log)
    """
  }
}
