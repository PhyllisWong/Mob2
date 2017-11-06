//
//  CommentViewCell.swift
//  product-hunt
//
//  Created by djchai on 11/5/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class CommentViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bodyTextField: UITextView!
    
    var comment: Comment? {
        didSet {
            userNameLabel.text = comment?.name
            bodyTextField.text = comment?.body
        }
    }
}


