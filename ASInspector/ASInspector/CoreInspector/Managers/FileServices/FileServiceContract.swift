//
//  FileServiceContract.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

protocol FileServiceContract {
  func removeAllLogs()
  func removeAllLogs<T: LoggerProtocol>(for type: T.Type)
  func removeLog<T: LoggerProtocol>(for type: T.Type, with identifier: String)
}
