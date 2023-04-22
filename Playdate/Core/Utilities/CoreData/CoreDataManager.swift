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
        container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Error loading Core Data. \(error)")
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
