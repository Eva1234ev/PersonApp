//
//  Person+CoreDataProperties.swift
//  PersonApp
//
//  Created by Eva on 10/24/19.
//  Copyright © 2019 Eva. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var time: String?
    @NSManaged public var name: String?
    @NSManaged public var itemId: String?
    @NSManaged public var image: String?
    @NSManaged public var desc: String?

}
