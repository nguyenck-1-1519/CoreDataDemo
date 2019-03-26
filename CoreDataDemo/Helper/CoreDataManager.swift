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

    func fetchAllPerson() -> [Person] {
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "age", ascending: true)]

        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error {
            Alert.showErrorAlert(withMessage: error.localizedDescription)
        }
        return []
    }

    func fetchAllBooks() -> [Book] {
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<Book>(entityName: "Book")

        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error {
            Alert.showErrorAlert(withMessage: error.localizedDescription)
        }
        return []
    }

    func savePerson(firstName: String, lastName: String, age: Int) -> Person? {
        let managedContext = getContext()
        let person = Person(context: managedContext)
        person.age = Int16(age)
        person.firstName = firstName
        person.lastName = lastName

        do {
            try managedContext.save()
            return person
        } catch let error {
            Alert.showErrorAlert(withMessage: error.localizedDescription)
        }
        return nil
    }

    func addBook(title: String, price: Float, person: Person) {
        let managedContext = getContext()
        let book = Book(context: managedContext)
        book.title = title
        book.price = price
        book.owner = person
        let books  = person.mutableSetValue(forKey: #keyPath(Person.own))
        books.add(book)

        do {
            try managedContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
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
