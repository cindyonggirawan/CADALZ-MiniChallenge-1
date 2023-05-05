//
//  CoreDataManager.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 19/04/23.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        NSImageTransformer.register()
        
        container = NSPersistentContainer(name: "CoreDataModel")
        let url = URL.storeURL(for: "group.playdate-group", databaseName: "CoreDataModel")
        let storeDescription = NSPersistentStoreDescription(url: url)
        
        container.persistentStoreDescriptions = [storeDescription]
        
        container.loadPersistentStores { desc, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}

public extension URL {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Unable to create URL for \(appGroup)")
        }
        
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
