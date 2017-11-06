//
//  CommentsDataModel.swift
//  product-hunt
//
//  Created by djchai on 11/3/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation


struct CommentsList: Decodable {
    let comments: [Comment]
}
struct Comment {
    let body: String
    let name: String
    let username: String
}

extension Comment: Decodable {
    
    enum CommentKeys: String, CodingKey {
        case body
        case user
    }
    
    enum UserKeys: String, CodingKey {
        case username
        case name
    }
    
    init(from decoder: Decoder) throws {
        // Defining the (keyed) container
        let container = try decoder.container(keyedBy: CommentKeys.self)
        let body: String = try container.decodeIfPresent(String.self, forKey: .body) ?? "No comment available"
        let user = try container.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        let name = try user.decode(String.self, forKey: .name)
        let username = try user.decode(String.self, forKey: .username)
        print("decode the body")
        self.init(body: body, name: name, username: username)
    }
}
















