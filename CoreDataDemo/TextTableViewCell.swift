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

    func configCell(withPerson person: Person) {
        contentLabel.text = "\(person.firstName ?? "") \(person.lastName ?? "") - \(person.age)"
    }

    func configCell(withBook book: Book) {
        contentLabel.text = "\(book.title ?? "") -- \(book.price)"
    }
}

