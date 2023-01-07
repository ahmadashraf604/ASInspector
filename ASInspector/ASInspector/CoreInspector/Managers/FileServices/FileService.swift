//
//  FileManager.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

class FileService {
  static let shared = FileService()
  private let fileManager: FileManager
  private var queue: DispatchQueue
  
  init(fileManager: FileManager = .default) {
    self.fileManager = fileManager
    let label = (Bundle.main.bundleIdentifier ?? "") + ".FileService"
    self.queue = .init(label: label, qos: .userInteractive, attributes: .concurrent)
  }
}

// MARK: - FileServiceContract Confirmation
extension FileService: FileServiceContract {
  func removeAllLogs() {
    removeFile(at: baseCachesDirectory)
  }
  
  func removeAllLogs<T: LoggerProtocol>(for type: T.Type) {
    let url = getLogDirectory(for: type)
    removeFile(at: url)
  }
  
  func removeLog<T: LoggerProtocol>(for type: T.Type, with identifier: String) {
    let url = getLogFileURL(for: type, with: identifier)
    removeFile(at: url)
  }
}

// MARK: - Private Helpers
private extension FileService {
  
  var baseCachesDirectory: URL? {
    guard let cachesDirecotry = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
      return nil
    }
    let baseDirecory = cachesDirecotry.appendingPathComponent(kBaseDirectory)
    guard fileExists(at: baseDirecory) else {
      return createDirectory(at: baseDirecory)
    }
    return baseDirecory
  }
  
  func getTempDirectory() -> URL? {
    let tempDirUrl = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
      .appendingPathComponent(kBaseDirectory)
      .appendingPathComponent(kMultimediaDirectory)
    guard fileExists(at: tempDirUrl) else {
      return createDirectory(at: tempDirUrl)
    }
    return tempDirUrl
  }
  
  func getLogsDirectory(for type: String) -> URL? {
    guard let baseCachesDirectory = baseCachesDirectory else {
      return nil
    }
    let logURL = baseCachesDirectory.appendingPathComponent(type)
    guard fileExists(at: logURL) else {
      return createDirectory(at: logURL)
    }
    return logURL
  }
  
  func getLogDirectory<T: LoggerProtocol>(for type: T.Type) -> URL? {
    let typeName = String(describing: type)
    return getLogsDirectory(for: typeName)
  }
  
  func getLogFileURL<T: LoggerProtocol>(for type: T.Type, with logID: String) -> URL? {
    let typeName = String(describing: type)
    let fileName = getLogFileName(for: logID)
    return getLogsDirectory(for: typeName)?.appendingPathComponent(fileName)
  }
  
  func getLogFileName(for logId: String) -> String {
    return "Log-\(logId).dat"
  }
  
  func createDirectory(at url: URL, isDirectory: Bool = true) -> URL? {
    do {
      try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
      return url
    } catch {
      print("Failed to create \(url) with error: \(error.localizedDescription)")
      return nil
    }
  }
  
  @discardableResult
  func removeFile(at url: URL?) -> Bool {
    guard let url = url else { return false }
    do {
      try fileManager.removeItem(at: url)
      return true
    } catch {
      print("Failed to remove \(url) directory with error: \(error.localizedDescription)")
      return false
    }
  }
  
  func fileExists(at url: URL) -> Bool {
    if #available(iOS 16.0, *) {
      return fileManager.fileExists(atPath: url.path())
    } else {
      return fileManager.fileExists(atPath: url.path)
    }
  }
  @discardableResult
  func write(data: Data?, in fileURL: URL?) -> Bool {
    guard let data = data else {
      return false
    }
    guard let fileURL = fileURL else {
      return false
    }
    do {
      try data.write(to: fileURL)
      return true
    } catch {
      print("Failed to write data in file: \(fileURL) with error: \(error.localizedDescription)")
      return false
    }
  }
}

// MARK: - IO Operation
extension FileService {
  func saveLogsDataOnDisk<T: LoggerProtocol>(_ logData: T, completion: (() -> Void)?) {
    queue.async { [weak self] in
      defer { completion?() }
      guard let logFileURL = self?.getLogFileURL(for: T.self, with: logData.identifier) else { return }
      do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: logData, requiringSecureCoding: true)
        try data.write(to: logFileURL)
      } catch {
        print("unable to save data in path \(logFileURL) with error: \(error.localizedDescription)")
      }
    }
  }
  
  func getLogData<T: LoggerProtocol>(for logId: String, completion: @escaping (_ logData: T?) -> Void) {
    queue.async { [weak self] in
      var logData: T?
      defer {
        DispatchQueue.main.safeAsync {
          completion(logData)
        }
      }
      guard let logFileURL = self?.getLogFileURL(for: T.self, with: logId) else { return }
      do {
        let data = try Data(contentsOf: logFileURL)
        logData = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSURLRequest.self, URLResponse.self, NSString.self, NSData.self, NSNumber.self, NSDate.self, URLResponse.self, NSURLRequest.self, T.self], from: data) as? T
      } catch {
        print("Can't get data from file \(logFileURL) with error: \(error.localizedDescription)")
      }
    }
  }
  
  func writeMedia(data: Data, ext: String, completion: @escaping (_ fileURL: URL?) -> Void) {
    queue.async { [weak self] in
      var fileURL: URL?
      defer {
        completion(fileURL)
      }
      guard let tempUrl = self?.getTempDirectory() else { return }
      fileURL = tempUrl.appendingPathComponent(UUID().uuidString)
      fileURL = fileURL?.appendingPathExtension(ext)
      self?.write(data: data, in: fileURL)
    }
  }
}
