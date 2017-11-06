//
//  CommentsTableVC.swift
//  product-hunt
//
//  Created by djchai on 11/3/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class CommentsTableVC: UITableViewController {
    
    var commentsList = [Comment]()
    var id: Int?
    var productName: String?
    

    override func viewDidLoad() {
//        print("Here")
        super.viewDidLoad()
        self.tableView.rowHeight = 150
        self.title = self.productName
        
        if let id = id {
            Networking().fetch(resource: .comments(postId: id)) { (result) in
                DispatchQueue.main.async {
                    guard let commentsList = result as? [Comment] else { return }
                    self.commentsList = [Comment]()
                    self.commentsList = commentsList
                    self.tableView.reloadData()
                    
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentViewCell", for: indexPath) as! CommentViewCell

//        print("some shit here!")
        cell.comment = commentsList[indexPath.row]
        return cell
    }
    

}
