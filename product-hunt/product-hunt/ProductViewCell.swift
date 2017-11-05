//
//  ProductViewCell.swift
//  product-hunt
//
//  Created by djchai on 10/30/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit
import WebKit

class ProductViewCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var votesCount: UILabel!
//    @IBOutlet weak var image: WKWebView!
    
    var post: Post? {
        didSet {
            productName.text = post?.name
            tagline.text = post?.tagline
            votesCount.text = "\(post?.votesCount ?? 0)"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
