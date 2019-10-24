//
//  AppDelegate.swift
//  PersonApp
//
//  Created by Eva on 10/11/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
           CoreDataManager.sharedManager.saveContext()
       }
}



