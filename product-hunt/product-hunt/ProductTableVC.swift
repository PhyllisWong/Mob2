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
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 110
        let networking = Networking()
        networking.fetchPost() { (posts) in
            DispatchQueue.main.async {
//                guard let posts = result as? [Post] else {return}
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductViewCell
        let raw = indexPath.item
        cell.post = posts[raw]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPost = posts[indexPath.row]
        let id = selectedPost.id
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let commentsTVC  = storyboard.instantiateViewController(withIdentifier: "CommentsTableVC") as! CommentsTableVC
        
        commentsTVC.id = id
        
//        self.navigationController?.pushViewController(commentsTVC, animated: true)
        self.performSegue(withIdentifier: "commentSegue", sender: self)
        
        
    }
}

