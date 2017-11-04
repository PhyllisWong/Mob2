//
//  ProductTableVC.swift
//  product-hunt
//
//  Created by djchai on 10/30/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class ProductTableVC: UITableViewController {
    
    // Empty array to hold the posts fetched from data
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Instance of networking class
        let networking = Networking()
        // calling the fetch callback on the instance of networking
        networking.fetchPost() { (posts) in
            // Tell the async queue to bring the data back to the main thread
            DispatchQueue.main.async {
                // populates the posts array in the main thread
                self.posts = posts
                // update the viewController with the data
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "commentSegue", sender: self)
    }
}

