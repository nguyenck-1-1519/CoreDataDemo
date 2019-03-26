//
//  BooksViewController.swift
//  CoreDataDemo
//
//  Created by can.khac.nguyen on 3/26/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var listBook: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        listBook = CoreDataManager.shared.fetchAllBooks()
    }
}

extension BooksViewController: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBook.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell") as? TextTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(withBook: listBook[indexPath.row])
        return cell 
    }
}
