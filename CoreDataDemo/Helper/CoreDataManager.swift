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

    func fetchAllPerson() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")

        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error {
            Alert.showErrorAlert(withMessage: error.localizedDescription)
        }
        return []
    }

    func savePerson(firstName: String, lastName: String, age: Int) -> NSManagedObject? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
}
