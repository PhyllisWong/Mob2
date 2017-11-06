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
    @IBOutlet weak var productImage: WKWebView!
    
    var post: Post? {
        didSet {
            productName.text = post?.name
            tagline.text = post?.tagline
            votesCount.text = "votes: \(post?.votesCount ?? 0)"
            let request = URLRequest(url: (post?.imageUrl)!)
            productImage.load(request)
        }
    }

}
