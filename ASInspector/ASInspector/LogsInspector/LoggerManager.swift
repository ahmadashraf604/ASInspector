//
//  LoggerManager.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 18/03/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation
import CoreData

class LoggerManager {
  static let shared = LoggerManager()
  // MARK: - Properties
  private let mainContext: NSManagedObjectContext
  private let backgroundContext: NSManagedObjectContext
  private let logsLimit: Int
  
  init(
    mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext,
    backgroundContext: NSManagedObjectContext = CoreDataManager.shared.backgroundContext,
    logsLimit: Int = 10_000
  ) {
    self.mainContext = mainContext
    self.backgroundContext = backgroundContext
    self.logsLimit = logsLimit
    
    self.deleteAllLogs()
  }
  
  // MARK: - Save
  func save(_ logData: LogData) {
    let logs: [LogEntity] = fetchAllLogs()
    backgroundContext.performAndWait {
      if logs.count >= logsLimit,
         let firstLog = logs.first {
        let objectID = firstLog.objectID
        
        if let logInContext = try? backgroundContext.existingObject(with: objectID) {
          backgroundContext.delete(logInContext)
        }
      }
      guard let logger = NSEntityDescription.insertNewObject(
        forEntityName: LogEntity.entityName,
        into: backgroundContext
      ) as? LogEntity
      else {
        print("Invalid Casting")
        return
      }
      logger.setData(logData)
      do {
        try backgroundContext.save()
      } catch let error {
        fatalError("Can't save Context with error: \(error)")
      }
    }
  }
}

// MARK: - Fetching Methods
extension LoggerManager {
  /// Fetch all logs in Core Data
  /// - Returns: array of rows `NetworkLoggerEntity`
  func fetchAllLogs(_ isAscending: Bool = true) -> [LogEntity] {
    let fetchRequest = NSFetchRequest<LogEntity>(entityName: LogEntity.entityName)
    let sortByDate = NSSortDescriptor(key: LogEntity.creationDateKey, ascending: isAscending)
    fetchRequest.sortDescriptors = [sortByDate]
    fetchRequest.returnsObjectsAsFaults = false
    var logs: [LogEntity] = .init()
    
    mainContext.performAndWait {
      do {
        logs = try mainContext.fetch(fetchRequest)
      } catch {
        print("Unable to fetch managed objects")
      }
    }
    return logs
  }
  
  func fetchAllLogs() -> [LogData] {
    fetchAllLogs().map { $0.getData() }
  }
}

// MARK: - Deleting Methods
extension LoggerManager {
  /// Delete all Logs Table rows
  func deleteAllLogs() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LogEntity.entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    backgroundContext.performAndWait {
      do {
        try backgroundContext.execute(deleteRequest)
        try backgroundContext.save()
      } catch {
        print("Delete all logs fail with error: \(error.localizedDescription)")
      }
    }
  }
}
