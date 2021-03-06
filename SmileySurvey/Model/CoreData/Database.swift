//
//  Database.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 31/12/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import CoreData

final class Database {
    
    static let shared = Database()
    
    private init() {
        mainContext.automaticallyMergesChangesFromParent = true
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSSharedPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("[STORE DESCRIPTION]", storeDescription)
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
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}

//final class NSSharedPersistentContainer: NSPersistentContainer {
//
//    override class func defaultDirectoryURL() -> URL {
//        let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.me.gorbuvla.SmileySurvey")
//        //storeURL = storeURL?.appendingPathComponent("MovieGo.sqlite")
//        return storeURL!
//    }
//}

extension NSManagedObjectContext {
    
    func saveIfNeeded() throws {
        guard hasChanges else { return }
        try save()
    }
}
