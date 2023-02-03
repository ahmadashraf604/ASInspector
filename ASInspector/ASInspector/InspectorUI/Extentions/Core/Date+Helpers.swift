//
//  Date+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation

// MARK: - Date + helpers
enum DateFormat: String {
  case time = "hh:mm:ss a"
}

extension Date {
  func toString(with format: DateFormat) -> String {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en")
    dateFormatter.dateFormat = format.rawValue
    return dateFormatter.string(from: self)
  }
}
