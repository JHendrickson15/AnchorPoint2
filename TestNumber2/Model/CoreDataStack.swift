//
//  CoreDataStack.swift
//  TestNumber2
//
//  Created by Jordan Hendrickson on 5/10/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "TestNumber2")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Unresolved Error\(error)")
            }
        })
        return persistentContainer
    }()
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
