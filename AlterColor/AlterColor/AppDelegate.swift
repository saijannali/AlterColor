//
//  AppDelegate.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.

// Assignment 02 4/27/2021
//
// Alter Color
//
// Serena Press - sapress@iu.edu
// Sai Jannali - sjannali@iu.edu
// Aidan Lesh - ailesh@iu.edu

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var allData: ColorDataModel = ColorDataModel(image:nil)
   // var savedData: SavedData = SavedData(data:[])
    let mySavedData: SavedData = SavedData(data:[])

    //writing to .plist
    func write_plist(){
        do {  
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            let arr2 = mySavedData.images
                //[ReminderItem(pContent: "\(self.myContent.text)", pCategory: "\(self.myCategory.text)", pDate: self.myDueDatePicker.date, pDone: false)]
            let arrfile2 = docsurl.appendingPathComponent("arr1.plist")
            let plister = PropertyListEncoder()
            plister.outputFormat = .xml // just so we can read it
            print("attempting successfully to write an array of ReminderItem by encoding to plist first")
            try plister.encode(arr2).write(to: arrfile2, options: .atomic)
            print("we didn't throw writing array of ReminderItem")
            let s = try String.init(contentsOf: arrfile2)
            print(s)
        }catch{
            print(error)
        }
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let lDocsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                            FileManager.SearchPathDomainMask.userDomainMask,
                                                            true).last
        
        if let lDocString: NSString = lDocsPath as NSString? {
            let lFileNameWithPath = lDocString.appendingPathComponent("arr1.plist")
            print("lDocsPath is \(lDocsPath!)")
            print("lDcosPathString is \(lDocString)")
            print("in appDelegate: file name with path is \(lFileNameWithPath)")
            
            //reading from plist
            do {
                let fm = FileManager.default
                let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
                print("retrieving saved plist array of item")
                let arrfile2 = docsurl.appendingPathComponent("arr1.plist")
                let arraydata = try Data(contentsOf: arrfile2)
                let arr = try PropertyListDecoder().decode([savedImage].self, from:arraydata)
                mySavedData.images = arr
                print(arr)
            } catch {
                print(error)
            }
        // Override point for customizatisKon after application launch.
            }
            return true
        }



        // MARK: UISceneSession Lifecycle
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

        // MARK: - Core Data stack
         var persistentContainer: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
            */
            let container = NSPersistentContainer(name: "AlterColor")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                     
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
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
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
}
