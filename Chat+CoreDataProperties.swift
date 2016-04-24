//
//  Chat+CoreDataProperties.swift
//  WhaleTalk
//
//  Created by Koen Hendriks on 18/04/16.
//  Copyright © 2016 Koen Hendriks. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Chat {

    @NSManaged var lastMessageTime: NSDate?
    @NSManaged var messages: NSSet?

}
