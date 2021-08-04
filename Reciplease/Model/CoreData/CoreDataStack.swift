//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 30/07/2021.
//

import Foundation
import CoreData

// CoreData initialization for production with NSSQLiteStoreType as persistenStoreDescriptions.

class CoreDataStack {
    
    // MARK: - Properties
    
    static let shared = CoreDataStack()

    private let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    // MARK: - Initialization
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Reciplease")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}
