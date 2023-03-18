//
//  CoreDataManager.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 18/03/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation
import CoreData

// MARK: - CoreDataManager
class CoreDataManager {
  // MARK: - private Properties
  /// Core Data file name
  private let fileName = "ASInspector"
  // MARK: - Properties
  static let shared = CoreDataManager()
  /// Persistent Container type
  var type: String = NSSQLiteStoreType
  lazy var managedObjectModel: NSManagedObjectModel = getManagedObjectModel()
  lazy var persistentContainer: NSPersistentContainer = getPersistentContainer()
  lazy var mainContext: NSManagedObjectContext = getMainContext()
  lazy var backgroundContext: NSManagedObjectContext = getBackgroundContext()
  
  // MARK: - Init
  private init() {}
  
}

// MARK: - Private Helpers
private extension CoreDataManager {
  
  func getManagedObjectModel() -> NSManagedObjectModel {
    guard let modelURL = FileService.shared.getFile(fileName, withExtension: .careData) else {
      fatalError("\(fileName) not found in bundle")
    }
    guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Can't get NSManagedObjectModel from \(modelURL.absoluteString)")
    }
    return managedObjectModel
  }
  
  func getPersistentContainer() -> NSPersistentContainer {
    let persistentContainer = NSPersistentContainer(
      name: fileName,
      managedObjectModel: self.managedObjectModel
    )
    let description = persistentContainer.persistentStoreDescriptions.first
    description?.type = type
    persistentContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("was unable to load store \(error)")
      }
    }
    return persistentContainer
  }
  
  func getMainContext() -> NSManagedObjectContext {
    let context = self.persistentContainer.viewContext
    context.automaticallyMergesChangesFromParent = true
    return context
  }
  
  func getBackgroundContext() -> NSManagedObjectContext {
    let context = self.persistentContainer.newBackgroundContext()
    context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    return context
  }
}
