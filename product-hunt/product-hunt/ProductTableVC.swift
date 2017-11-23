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
    var list = [Post]()
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Hunt API"
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 150
        let networking = Networking()
        networking.fetch(resource: .posts) { (result) in
            DispatchQueue.main.async {
                guard let list = result as? [Post] else {return}
                self.list = list
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    // view the product data in the tableview cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductViewCell
        let raw = indexPath.item
        cell.post = list[raw]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPost = list[indexPath.row]
        let id = selectedPost.id
        let productName = selectedPost.name
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let commentsTVC  = storyboard.instantiateViewController(withIdentifier: "CommentsTableVC") as! CommentsTableVC
        
        commentsTVC.id = id
        commentsTVC.productName = productName
        
//        self.performSegue(withIdentifier: "commentSegue", sender: self)
        self.navigationController?.pushViewController(commentsTVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}





















