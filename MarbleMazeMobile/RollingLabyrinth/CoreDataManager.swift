//
//  CoreDataStorage.swift
//  RollingLabyrinth
//
//  Created by Hands, Connor A on 4/22/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "RollingLabyrinth") // Name of your data model
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error saving context: \(error)")
            }
        }
    }
}
