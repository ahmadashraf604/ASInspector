//
//  DataSize.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import struct Foundation.Data

#if os(Linux)
    import zlibLinux
#else
    import zlib
#endif

enum DataSize {
  
  static let chunk = 1 << 14
  static let stream = MemoryLayout<z_stream>.size
}
