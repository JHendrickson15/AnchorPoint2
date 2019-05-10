//
//  List+Convenience.swift
//  TestNumber2
//
//  Created by Jordan Hendrickson on 5/10/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import Foundation
import CoreData

extension List { // formatting for list profiles
    @discardableResult
    convenience init(name: String , context: NSManagedObjectContext = CoreDataStack.context ) {
        //convenience initializer for list format
        self.init(context: context)
        
        self.name = name
        self.isComplete = false
    }
}
