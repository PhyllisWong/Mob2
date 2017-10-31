//
//  ProductTableVC.swift
//  product-hunt
//
//  Created by djchai on 10/30/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit




class ProductTableVC: UITableViewController {
    
    // Placeholder to format view cells
    let products = [
        "Product 1",
        "Product 2",
        "Product 3",
        "Product 4"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }
}

