//
//  FileMeta.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

struct FileMeta {
  // Offset for signature read
  let offset: Int
  let signature: [UInt8]
  var ext: String?
  let mimeType: String?
  let contentType: ContentType
  
  init(offset: Int = 0, signature: [UInt8] = [], ext: String?, mime: String?, contentType: ContentType) {
    self.offset = offset
    self.signature = signature
    self.ext = ext
    self.mimeType = mime
    self.contentType = contentType
  }
}
