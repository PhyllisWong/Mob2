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
    let commentsCount : Int
    let name : String
    let tagline : String
    let id : Int
    //    let thumbnail : Thumbnail
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
        case id
        case tagline = "tagline"
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
        let name: String = try container.decodeIfPresent(String.self, forKey: .name) ?? "No name"
        let tagline: String = try container.decodeIfPresent(String.self, forKey: .tagline) ?? "No tagline"
        let votesCount: Int = try container.decodeIfPresent(Int.self, forKey: .votesCount) ?? 0
        let id: Int = try container.decode(Int.self, forKey: .id)
        
        // thumbnail container
        //        let thumbnailContainer = try container.nestedContainer(keyedBy: ImageResultKey.self, forKey: .thumbnail)
        //
        //        let thumbnail = try thumbnailContainer.decodeIfPresent(Thumbnail.self, forKey: .imageURL) ?? Thumbnail(imageURL: "")
        
        self.init(commentsCount: commentsCount, name: name, tagline: tagline, id: id, votesCount: votesCount)
        
    }
}
