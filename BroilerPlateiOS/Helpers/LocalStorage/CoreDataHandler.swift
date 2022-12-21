//
//  CoreDataHandler.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 24/10/2022.
//

import Foundation
import CoreData

class CoreDataHandler {
    
    // MARK:- Shared Instance
    private static var instance = CoreDataHandler()
    
    // MARK:- Properties
    private let persistentContainer: NSPersistentContainer
    private var isPersistentContainerLoaded: Bool = false
    public var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    // MARK:- Initializer
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "abc")
        persistentContainer.loadPersistentStores { storeDescription, error in
            
            if let error = error as NSError? {
                print(error.localizedDescription)
                self.isPersistentContainerLoaded = false
            } else {
                self.isPersistentContainerLoaded = true
            }
            
        }
        
    }
    
    // MARK:- Custom Methods
    public static func sharedInstance() -> CoreDataHandler {
        instance
    }
    
    func printDirectoryURL() {
        print("DirectoryURL: ", NSPersistentContainer.defaultDirectoryURL())
    }
    
    func saveChanges(completion: (_ error: String?) -> ()) {

        if !isPersistentContainerLoaded {
            completion("Unexpected error")
            return
        }

        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error.localizedDescription)
            }
        } else {
            completion(nil)
        }

    }
    
    func fetchData<T: NSManagedObject>(type: T.Type, completion: @escaping (_ results: [T]?, _ error: String?) -> ()) {
        
        if !isPersistentContainerLoaded {
            DispatchQueue.main.async {
                completion(nil, "Unexpected error")
            }
            return
        }

        let viewContext = persistentContainer.viewContext
        do {
            let results = try viewContext.fetch(type.fetchRequest())
            
            DispatchQueue.main.async {
                if let data = results as? [T] {
                    completion(data, nil)
                }
            }
            
        } catch {
            DispatchQueue.main.async {
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    
    func delete(uri: URL, completion: @escaping (_ error: String?) -> ()) {
        
        if !isPersistentContainerLoaded {
            DispatchQueue.main.async {
                completion("Unexpected error")
            }
            return
        }
        let viewContext = persistentContainer.viewContext
        guard let objectId = viewContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: uri) else {
            DispatchQueue.main.async {
                completion("Unexpected error")
            }
            return
        }
        let object = viewContext.object(with: objectId)
        viewContext.delete(object)
        saveChanges(completion: completion)
        
    }

}
