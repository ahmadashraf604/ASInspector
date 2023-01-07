//
//  LoggerProtocol.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

protocol LoggerProtocol: NSCoding, NSSecureCoding {
  var identifier: String { get }
}
