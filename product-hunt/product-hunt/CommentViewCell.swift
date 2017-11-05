//
//  CommentViewCell.swift
//  product-hunt
//
//  Created by djchai on 11/5/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class CommentViewCell: UITableViewCell {
    
    @IBOutlet weak var ProductNameLabel: UILabel!
    @IBOutlet weak var CommentBodyLabel: UILabel!
    
    var comment: Comment? {
        didSet {
            CommentBodyLabel.text = comment?.body
        }
    }
}


