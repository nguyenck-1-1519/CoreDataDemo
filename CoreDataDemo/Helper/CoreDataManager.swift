//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by can.khac.nguyen on 3/22/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private func getContext() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
        return appDelegate.persistentContainer.viewContext
    }

    func fetchAllPerson() -> [NSManagedObject] {
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "age", ascending: true)]

        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error {
            Alert.showErrorAlert(withMessage: error.localizedDescription)
        }
        return []
    }

    func savePerson(firstName: String, lastName: String, age: Int) -> NSManagedObject? {
        let managedContext = getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext) else {
            Alert.showErrorAlert(withMessage: "Cant get entity")
            return nil
        }
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(firstName, forKey: "firstName")
        person.setValue(lastName, forKey: "lastName")
        person.setValue(age, forKeyPath: "age")

        do {
            try managedContext.save()
            return person
        } catch let error {
            Alert.showErrorAlert(withMessage: error.localizedDescription)
        }
        return nil
    }

    func updatePerson(withObjectId objectId: NSManagedObjectID, firstName: String, lastName: String, age: Int) -> Bool {
        let managedContext = getContext()
        let objectUpdate = managedContext.object(with: objectId)
        objectUpdate.setValue(firstName, forKey: "firstName")
        objectUpdate.setValue(lastName, forKey: "lastName")
        objectUpdate.setValue(age, forKey: "age")
        do {
            try managedContext.save()
        } catch let error {
            print(error.localizedDescription)
            return false
        }
        return true
    }

    func deleteObject(manageObject: NSManagedObject) -> Bool {
        let managedContext = getContext()
        let objectDelete = managedContext.object(with: manageObject.objectID)
        managedContext.delete(objectDelete)
        do {
            try managedContext.save()
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
}
