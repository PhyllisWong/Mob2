//
//  ProductTableVC.swift
//  product-hunt
//
//  Created by djchai on 10/30/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

// Placeholder to format view cells
enum Mood: String {
    case happy = "😀"
    case bot = "🤖"
    case cowboy = "🤠"
    case poop = "💩"
}


class ProductTableVC: UITableViewController {
    
    let moods: [Mood] = [
        .happy,
        .bot,
        .cowboy,
        .poop
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moods.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text = moods[indexPath.row].rawValue
        return cell
    }
}

