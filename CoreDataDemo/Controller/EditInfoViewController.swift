//
//  EditInfoViewController.swift
//  CoreDataDemo
//
//  Created by can.khac.nguyen on 3/25/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit
import CoreData

class EditInfoViewController: UIViewController {
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!

    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextfield.text = person.value(forKey: "firstName") as? String
        lastNameTextfield.text = person.value(forKey: "lastName") as? String
        let age = person.value(forKey: "age") as? Int
        ageTextfield.text = String(age ?? 0)
    }

    @IBAction func onUpdateButtonClicked(_ sender: Any) {
        guard let firstName = firstNameTextfield.text, !firstName.isEmpty,
            let lastName = lastNameTextfield.text, !lastName.isEmpty,
            let ageString = ageTextfield.text, !ageString.isEmpty else {
                Alert.showErrorAlert(withMessage: "Fill full info befor add")
                return
        }
        guard let age = Int(ageString) else {
            Alert.showErrorAlert(withMessage: "Please fill age's value with a valid number")
            return
        }
        let isSuccess = CoreDataManager.shared.updatePerson(withObjectId: person.objectID,
                                            firstName: firstName, lastName: lastName, age: age)
        if isSuccess {
            Alert.showErrorAlert(withMessage: "update success") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            Alert.showErrorAlert(withMessage: "update fail")
        }
    }

    @IBAction func onAddButtonClicked(_ sender: Any) {
        guard let title = titleTextfield.text, !title.isEmpty,
            let priceString = priceTextfield.text, !priceString.isEmpty,
            let price = Float(priceString) else {
            Alert.showErrorAlert(withMessage: "plz fill all info before adding")
            return
        }
        CoreDataManager.shared.addBook(title: title, price: price, person: person)
        tableView.reloadData()
        titleTextfield.text = ""
        priceTextfield.text = ""
    }
}

extension EditInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let books = person.own?.allObjects else {
            return 0
        }
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell") as? TextTableViewCell else {
            return UITableViewCell()
        }
        guard let books = person.own?.allObjects as? [Book] else {
            return UITableViewCell()
        }
        cell.configCell(withBook: books[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let books = person.own?.allObjects as? [Book] else {
                return
            }
            let isSuccess = CoreDataManager.shared.deleteObject(manageObject: books[indexPath.row])
            if isSuccess {
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                Alert.showErrorAlert(withMessage: "error")
            }
        }
    }
}
