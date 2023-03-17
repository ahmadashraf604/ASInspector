//
//  NetworkRepresentable.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation

protocol NetworkRepresentable {
  var url: String? { get }
  var status: String? { get }
  var method: String? { get }
  var duration: String? { get }
  var date: String? { get }
}
