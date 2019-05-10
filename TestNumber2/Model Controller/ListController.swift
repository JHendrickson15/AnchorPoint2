//
//  ListController.swift
//  TestNumber2
//
//  Created by Jordan Hendrickson on 5/10/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import Foundation
import CoreData

class ListController {
    //MARK: Singleton
    static let shared = ListController()
    //Mark: Property
    let fetchedResultsController: NSFetchedResultsController<List>
    
    init() {
        //creates request
        let fetchRequest: NSFetchRequest<List> = List.fetchRequest()
        // add the sort descriptors. these allow us to determine how we want to organize our data from the fetch request
        fetchRequest.sortDescriptors = [(NSSortDescriptor(key: "isComplete", ascending: true))]
        // initialize a ne NSFetchRequestsController using the fetch we created above
        let resultsController: NSFetchedResultsController<List> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        // set the initialized NSFRC to our property
        fetchedResultsController = resultsController
        
        do{ // the do try cath will tell me if there is ann error or if the fetch request fails
            try fetchedResultsController.performFetch()
        }catch{
            print("there was an error performing the fetch!! \(error.localizedDescription)")
        }
    }
    //Mark: CRUD Functions
    
    //create
    func add(name: String, isComplete: Bool){
        List(name: name)
        saveToPersistentStore()
    }
    //delete
    func delete(list: List) {
        if let moc = list.managedObjectContext{
            moc.delete(list)
            saveToPersistentStore()
        }
    }
    //update
    func update(list: List , name: String , isComplete: Bool){
        list.name = name
        list.isComplete = isComplete
        saveToPersistentStore()
    }
    //update bool
    func toggleIsComplete(list: List){
        list.isComplete = !list.isComplete
        saveToPersistentStore()
    }
    func saveToPersistentStore() { //save changes to coredata
        let moc = CoreDataStack.context
        do{
            try moc.save()
        }catch{
            print("There was an error saving to the persistent Store \(error)")
        }
    }
}//end of class

