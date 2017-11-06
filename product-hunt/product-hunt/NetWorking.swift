//
//  NetWorking.swift
//  product-hunt
//
//  Created by djchai on 11/1/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation

/*
 Parts of the HTTP Request
 1. Request Method: GET, PUT, DELETE or POST
 2. Header
 3. URL Path
 4. URL Parameters
 5. Body
 */

// #1
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Resource {
    case posts
    case comments(postId: Int)
    
    // #1
    func httpMethod() -> HTTPMethod {
        switch self {
        case .posts, .comments:
            return .get
        }
    }
    
    // #2
    func header(token: String) -> [String: String] {
        switch self {
        case .posts, .comments:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(token)",
                    "Host": "api.producthunt.com"
            ]
        }
    }
    
    // #3
    func path() -> String {
        switch self {
        case .posts:
            return "/me/feed"
        case .comments:
            return "/comments"
        }
    }
    
    // #4
    func urlParameters() -> [String: String] {
        switch self {
        case .comments(let postId):
            return ["search[post_id]": String(postId)]
        case .posts:
            return [:]
        }
    }
    
    // #5
    func body() -> Data? {
        switch self {
        case .posts, .comments:
            return nil
        }
    }
}


class Networking {
    let session = URLSession.shared
    let baseURL = "https://api.producthunt.com/v1/"
    
    func fetch(resource: Resource, completion: @escaping ([Decodable]) -> ()) {
        let fullURL = baseURL + resource.path()
        var item = NSURLQueryItem()
       
        
        let componets = NSURLComponents(string: fullURL)
        for (key, value) in resource.urlParameters() {
            item = NSURLQueryItem(name: key, value: value)
        }
        
        componets?.queryItems = [item as URLQueryItem]
        
        let url = componets?.url
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = resource.header(token: "d11bcb361e17fc5272675f5d2fc9d33dbf20e6312019c0a50a7c30bd5d6b1ba6")
        request.httpMethod = resource.httpMethod().rawValue
        
        session.dataTask(with: request) { (data, res, err) in
            if let data = data {
                switch resource {
                case .posts:
                    let postList = try? JSONDecoder().decode(PostsLists.self, from: data)
                    guard let posts = postList?.posts else { return }
//                    print("do something")
                    return completion(posts)
                    
                case .comments:
                    let commentList = try? JSONDecoder().decode(CommentsList.self, from: data)
                    guard let comments = commentList?.comments else { return }
//                    print("do something else")
                    return completion(comments)
                }
            }
        }.resume()
    }
}




















