//
//  MockCoreDataStack.swift
//  Projet10Tests
//
//  Created by Raphaël Goupille on 17/11/2021.
//

import Foundation
import Projet10
import CoreData

class MockCoreDataStack: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "Projet10")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { persistentStoreDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
    
}
