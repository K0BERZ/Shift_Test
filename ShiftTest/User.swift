//
//  User.swift
//  ShiftTest
//
//  Created by Константин Березовский on 2023-04-23.
//

import CoreData

@objc(Note)
class Note: NSManagedObject {
    @NSManaged var name: String!
    @NSManaged var surname: String!
    @NSManaged var password: String!
    @NSManaged var dateOfBirth: Date!
}
