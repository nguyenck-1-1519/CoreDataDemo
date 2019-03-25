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

    var person: NSManagedObject!
    
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
}
