//
//  CoreDataManager.swift
//  PersonApp
//
//  Created by Eva on 10/24/19.
//  Copyright © 2019 Eva. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit
typealias completion = ([NSManagedObject]?)->()

class CoreDataManager {
    
    //1
    static let sharedManager = CoreDataManager()
    private init() {} 
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PersonApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /*Insert*/
    func insertPerson(name: String, desc : String)->Person? {
        
        
        let managedContext = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person",
                                                in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        //        dateFormatter.locale = NSLocale.current
        //        dateFormatter.dateFormat = "dd-MMMM-yyyy HH:mm"
        //        let time = dateFormatter.string(from: Date())
        
        let itemId = String(Int.random(in: 0 ..< 100))
        person.setValue(name, forKeyPath: "name")
        person.setValue(desc, forKeyPath: "desc")
        person.setValue(String(Date().millisecondsSince1970), forKeyPath: "time")
        person.setValue(" ", forKeyPath: "image")
        person.setValue(itemId, forKey: "itemId")
        do {
            try managedContext.save()
            return person as? Person
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func update(name:String, desc : String, person : Person) {
        
        let context = persistentContainer.viewContext
        
        do {
            
            person.setValue(name, forKey: "name")
            person.setValue(desc, forKey: "desc")
            
            
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    /*delete*/
    func delete(person : Person){
        
        let managedContext = persistentContainer.viewContext
        
        do {
            
            managedContext.delete(person)
            
        } catch {
            
            print(error)
        }
        
        do {
            try managedContext.save()
        } catch {
            
        }
    }
    
    func fetchAllPersons() -> [Person]?{
        
        
        
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [Person]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    func deleteAll(){
        
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let deleteRequest = NSBatchDeleteRequest( fetchRequest: fetchRequest)
        
        do{
            try managedContext.execute(deleteRequest)
            do {
                try managedContext.save()
                UserDefaults.standard.set(false, forKey: "isAllreadyFetch")
            } catch {
                
            }
        }catch _ as NSError {
        }
    }
    
    func delete(itemId: String) -> [Person]? {
        
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        fetchRequest.predicate = NSPredicate(format: "itemId == %@" ,itemId)
        do {
            
            
            let item = try managedContext.fetch(fetchRequest)
            var arrRemovedPeople = [Person]()
            for i in item {
                
                managedContext.delete(i)
                try managedContext.save()
                arrRemovedPeople.append(i as! Person)
            }
            return arrRemovedPeople
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    func flushData() {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let objs = try! persistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            persistentContainer.viewContext.delete(obj)
        }
        
        try! persistentContainer.viewContext.save()
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        
        return persistentContainer.newBackgroundContext()
    }()
    
    func fetchAllEntities(entityName : String, completion : @escaping completion ){
        
        backgroundContext.perform {
            
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            
            do {
                let managedObjectArray = try self.backgroundContext.fetch(fetchRequest)
                completion(managedObjectArray)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                completion(nil)
            }
        }
    }
    
    func fetchAllEntities1(entityName : String, completion : @escaping completion ){
        
        
        persistentContainer.performBackgroundTask { (managedContext) in
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            
            do {
                let managedObjectArray = try managedContext.fetch(fetchRequest)
                completion(managedObjectArray)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                completion(nil)
            }
        }
    }
}



