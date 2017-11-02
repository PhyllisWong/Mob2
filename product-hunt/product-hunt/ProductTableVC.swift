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
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networking = Networking()
        networking.fetchPost() { (posts) in
            DispatchQueue.main.async {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].name
        return cell
    }
}

