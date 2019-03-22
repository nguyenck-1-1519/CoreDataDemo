//
//  SecondViewController.swift
//  CoreDataDemo
//
//  Created by can.khac.nguyen on 3/22/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Alert.hiddenWindow()
    }
    
    @IBAction func onShowButtonClicked(_ sender: Any) {
        Alert.showErrorAlert(withMessage: "AHHHHHHHHHH")
    }

}
