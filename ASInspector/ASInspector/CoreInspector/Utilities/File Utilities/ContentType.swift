//
//  ContentType.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

enum ContentType {
  case text
  case json
  case image
  case pdf
  case audio
  case video
  case urlencoded
  case multipart
  case unknown(String?)
  
  func getName() -> String {
    switch self {
    case .text:
      return "Text"
    case .json:
      return "JSON"
    case .image:
      return "Image"
    case .pdf:
      return "PDF"
    case .audio:
      return "Audio"
    case .video:
      return "Video"
    case .urlencoded:
      return "x-www-form-urlencoded"
    case .multipart:
      return "Multipart form data"
    case .unknown(let name):
      if let title = name {
        return title
      }
      return "Unknown"
    }
  }
}
