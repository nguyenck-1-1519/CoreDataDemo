//
//  TextTableViewCell.swift
//  CoreDataDemo
//
//  Created by can.khac.nguyen on 3/22/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit
import CoreData

class TextTableViewCell: UITableViewCell {

    @IBOutlet private weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(withPerson person: NSManagedObject) {
        let firstName = person.value(forKey: "firstName") as? String
        let lastName = person.value(forKey: "lastName") as? String
        let age = person.value(forKey: "age") as? Int
        contentLabel.text = "\(firstName ?? "") \(lastName ?? "") - \(age ?? 0)"
    }

}
