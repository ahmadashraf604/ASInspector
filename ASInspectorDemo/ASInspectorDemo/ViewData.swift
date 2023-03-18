//
//  ViewData.swift
//  ASInspectorDemo
//
//  Created by Ahmed Ashraf on 03/02/2023.
//

import Foundation

struct ViewData {
  let title: String
  let action: (() -> Void)?
}

struct ViewSectionData {
  let title: String
  let list: [ViewData]
}
