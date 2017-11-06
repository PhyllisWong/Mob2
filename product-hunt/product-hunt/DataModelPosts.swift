//
//  DataModel.swift
//  product-hunt
//
//  Created by djchai on 11/1/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation

struct PostsLists: Decodable {
    let posts: [Post]
}

// Data structure to display in each tableViewCell
struct Post {
    let id : Int
    let name : String
    let tagline : String
    let votesCount : Int
    let imageUrl: URL
}


// Extend the Post struct to convert JSON to Swift naming convention
extension Post: Decodable {
    
    enum PostKeys: String, CodingKey {
        case id
        case name
        case tagline
        case votesCount = "votes_count"
        case thumbnail
    }
    
    // Data structure to access the image URL
    enum ThumbnailKeys: String, CodingKey {
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PostKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decodeIfPresent(String.self, forKey: .name) ?? "No name"
        let tagline: String = try container.decodeIfPresent(String.self, forKey: .tagline) ?? "No tagline"
        let votesCount: Int = try container.decodeIfPresent(Int.self, forKey: .votesCount) ?? 0
        let thumbnail = try container.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
        let imageUrl = try thumbnail.decode(URL.self, forKey: .imageURL)
        
        self.init(id: id, name: name, tagline: tagline, votesCount: votesCount, imageUrl: imageUrl)
        
    }
}
