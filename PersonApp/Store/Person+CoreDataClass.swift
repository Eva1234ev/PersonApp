//
//  Person+CoreDataClass.swift
//  PersonApp
//
//  Created by Eva on 10/24/19.
//  Copyright © 2019 Eva. All rights reserved.
//
//


import Foundation
import CoreData

typealias Persons = [Person]
@objc(Person)
public class Person: NSManagedObject, Codable {
    
    enum apiKey: String, CodingKey {
        case itemId
        case name
        case image
        case time
        case desc = "description"
       
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        
        guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
            let manageObjContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
            let manageObjList = NSEntityDescription.entity(forEntityName: "Person", in: manageObjContext) else {
                fatalError("failed")
        }
        
        self.init(entity: manageObjList, insertInto: manageObjContext)
        let container = try decoder.container(keyedBy: apiKey.self)
        self.itemId = try container.decodeIfPresent(String.self, forKey: .itemId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.time = try container.decodeIfPresent(String.self, forKey: .time)
     
    }
    
    // MARK: - encode
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: apiKey.self)
        try container.encode(itemId, forKey: .itemId)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(desc, forKey: .desc)
        try container.encode(time, forKey: .time)
      
    }
    static func ==(lhs: Person, rhs: Person) -> Bool {
        let areEqual = lhs.itemId == rhs.itemId
        
        return areEqual
    }
}
