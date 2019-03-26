//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by can.khac.nguyen on 3/21/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var people: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        people = CoreDataManager.shared.fetchAllPerson()
    }

    private func clearTextField() {
        firstNameTextfield.text = ""
        lastNameTextfield.text = ""
        ageTextfield.text = ""
    }

    @IBAction func onAddButtonClicked(_ sender: UIButton) {
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
        if let person = CoreDataManager.shared.savePerson(firstName: firstName, lastName: lastName, age: age) {
            people.append(person)
            tableView.reloadData()
            clearTextField()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell") as? TextTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(withPerson: people[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "EditInfoViewController") as? EditInfoViewController else {
            return
        }
        viewController.person = people[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let isSuccess = CoreDataManager.shared.deleteObject(manageObject: people[indexPath.row])
            if isSuccess {
                people.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                Alert.showErrorAlert(withMessage: "error")
            }
        }
    }
}

