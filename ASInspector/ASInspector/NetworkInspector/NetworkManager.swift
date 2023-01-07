//
//  NetworkManager.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

class NetworkManager {
  public static let shared = NetworkManager()
  private let fileService: FileService
  private var logs: [UINetworkLogData] = []
  private let queue: DispatchQueue
  private let networkInterceptor: NetworkInterceptor
  
  init(
    fileService: FileService = .shared,
    networkInterceptor: NetworkInterceptor = NetworkInterceptor()
  ) {
    self.fileService = fileService
    self.networkInterceptor = networkInterceptor
    let queueLabel = (Bundle.main.bundleIdentifier ?? "") + ".NetworkManager"
    self.queue = .init(label: queueLabel, qos: .userInteractive, attributes: .concurrent)
    fileService.removeAllLogs(for: NetworkLogData.self)
  }
}

// MARK: - Public Helpers
extension NetworkManager {
  func startLogging() {
    networkInterceptor.startInterceptingNetwork()
  }
  
  func stopLogging() {
    networkInterceptor.stopInterceptingNetwork()
    clearAll()
  }
  
  @objc func clearAll() {
    queue.async(flags: .barrier) { [weak self] in
      self?.logs.removeAll()
      self?.fileService.removeAllLogs(for: NetworkLogData.self)
    }
  }
  
  func removeLog(at index: Int) {
    queue.async(flags: .barrier) { [weak self] in
      guard let self = self else { return }
      let log = self.logs[index]
      self.logs.remove(at: index)
      self.fileService.removeLog(for: NetworkLogData.self, with: log.identifier)
    }
  }
  
  
  func logData(_ logData: NetworkLogData, isResponse: Bool) {
    queue.async(flags: .barrier) { [weak self] in
      guard let self = self else { return }
      isResponse ? self.logResponse(logData) : self.logRequest(logData)
    }
  }
}

// MARK: - Private helpers
private extension NetworkManager {
  
  func logRequest(_ logData: NetworkLogData) {
    let logInfo = UINetworkLogData(from: logData)
    self.logs.append(logInfo)
    self.fileService.saveLogsDataOnDisk(logData, completion: nil)
    DispatchQueue.main.safeAsync {
      NotificationCenter.default.post(name: .logDataUpdate, object: nil, userInfo: [kLogID: logData.identifier, kIsResponseLogUpdate: false])
    }
  }
  
  func logResponse(_ logData: NetworkLogData) {
    let logInfo = UINetworkLogData(from: logData)
    for index in self.logs.indices where self.logs[index].identifier == logInfo.identifier {
      self.logs[index] = logInfo
    }
    self.fileService.saveLogsDataOnDisk(logData) {
      // Post response notification on completion of write operation
      DispatchQueue.main.safeAsync {
        NotificationCenter.default.post(name: .logDataUpdate, object: nil, userInfo: [kLogID: logData.identifier, kIsResponseLogUpdate: true])
      }
    }
  }
}
