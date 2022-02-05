//
//  AppDelegate.swift
//  ShoppingList Part II
//
//  Created by Paul STUART (000389223) on 10/13/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Shopping List Array
    var ShoppingList:[Product] = []
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.       
        copyDatabase()
        
        return true
    }
    
    // Get the Database Path for Shopping List
    func getDBPath()->String
    {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDir = paths[0]
        let databasePath = (documentDir as NSString).appendingPathComponent("shoppingDB.db")
        return databasePath;
    }
    
    // Read in the data ftom DB file for usage in the App
    func copyDatabase()
    {
        let filemanager = FileManager.default
        let dbPath = getDBPath()
        var success = filemanager.fileExists(atPath: dbPath)
        
        if(!success) {
            if let defaultDBPath = Bundle.main.path(forResource: "shoppingDB", ofType: "db")
            {
                var error:NSError?
                do {
                    try filemanager.copyItem(atPath: defaultDBPath, toPath: dbPath)
                    success = true
                } catch let error1 as NSError {
                    error = error1
                    success = false
                }
                print(defaultDBPath)
                if (!success) {
                    print("Failed to create writable database file with message\(error!.localizedDescription)")
                }
            } else {
                print("Cannot find File in NSBundle")
            }
        } else {
            print("File Already Exists At:\(dbPath)")
        }
    }

  

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

