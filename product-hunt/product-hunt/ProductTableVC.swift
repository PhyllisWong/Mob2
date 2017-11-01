//
//  ProductTableVC.swift
//  product-hunt
//
//  Created by djchai on 10/30/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

// Data structure to display in each tableViewCell
struct Post {
    let commentsCount : Int
    let name : String
    let tagLine : String
    let thumbnail : Thumbnail
    let votesCount : Int
}

// Data structure to access the image URL
struct Thumbnail: Decodable {
    let imageURL : String
}

// Extend the Post struct to convert JSON to Swift naming convention
extension Post: Decodable {
    
    enum PostKeys: String, CodingKey {
        case commentsCount = "comments_count"
        case name
        case tagLine = "tag_line"
        case thumbnail
        case votesCount = "votes_count"
    }
    
    enum ImageResultKey: String, CodingKey {
        case imageURL = "image_url"
    }
   
    init(from decoder: Decoder) throws {
        // Defining the (keyed) container
        let container = try decoder.container(keyedBy: PostKeys.self)
        
        let commentsCount: Int = try container.decodeIfPresent(Int.self, forKey: .commentsCount) ?? 0
        let name: String = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        let tagLine: String = try container.decodeIfPresent(String.self, forKey: .tagLine) ?? ""
        let votesCount: Int = try container.decodeIfPresent(Int.self, forKey: .votesCount) ?? 0
        
        // thumbnail container
        let thumbnailContainer = try container.nestedContainer(keyedBy: ImageResultKey.self, forKey: .thumbnail)
        let thumbnail = try thumbnailContainer.decode(Thumbnail.self, forKey: .imageURL)

        self.init(commentsCount: commentsCount, name: name, tagLine: tagLine, thumbnail: thumbnail, votesCount: votesCount)
       
    }
}

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

