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
}

extension Comment: Decodable {
    
    enum CommentKeys: String, CodingKey {
        case body
    }
    
    init(from decoder: Decoder) throws {
        // Defining the (keyed) container
        let container = try decoder.container(keyedBy: CommentKeys.self)
        
        let body: String = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        print("decode the body")
        self.init(body: body)
    }
}
