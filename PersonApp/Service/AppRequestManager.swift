//
//  AppRequestManager.swift
//  PersonApp
//
//  Created by Eva on 10/21/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit
import CoreData

class AppRequestManager: NSObject {
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    var arrayOfPerson : [Person] = []{
           didSet{
               reloadList()
           }
       }
    
    func getListData()  {
        guard let listURL = URL(string: "http://test.php-cd.attractgroup.com/test.json")else {
            return
        }
        URLSession.shared.dataTask(with: listURL){
            (data,response,error) in
            guard let jsonData = data else { return }
            DispatchQueue.main.async {
                self.parseResponse(forData: jsonData)
            }
        }.resume()
    }
    

    func parseResponse(forData jsonData : Data)  {
        do {
            guard let codableContext = CodingUserInfoKey.init(rawValue: "context") else {
                fatalError("Failed context")
            }
            
            let manageObjContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codableContext] = manageObjContext
            // Parse JSON data
            _ = try decoder.decode([Person].self, from: jsonData)
            ///context save
            try manageObjContext.save()
            UserDefaults.standard.set(true, forKey: "isAllreadyFetch")
            self.fetchLocalData()
        } catch let error {
            print("Error ->\(error.localizedDescription)")
            self.errorMessage(error.localizedDescription)
        }
    }
    
    
    func fetchLocalData()  {
        let manageObjContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        //Sort by id
//        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            self.arrayOfPerson = try manageObjContext.fetch(fetchRequest)
        } catch let error {
            print(error)
            self.errorMessage(error.localizedDescription)
        }
    }
    
}
