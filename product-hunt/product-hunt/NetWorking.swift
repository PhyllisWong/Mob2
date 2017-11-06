//
//  NetWorking.swift
//  product-hunt
//
//  Created by djchai on 11/1/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Resource {
    case posts
    case comments(postId: Int)
    
    func httpMethod() -> HTTPMethod {
        switch self {
        case .posts, .comments:
            return .get
        }
    }
    
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
    
    func path() -> String {
        switch self {
        case .posts:
            return "/me/feed"
        case .comments:
            return "/comments"
        }
    }
    
    func urlParameters() -> [String: String] {
        switch self {
        case .comments(let postId):
            return ["search[post_id]": String(postId)]
        case .posts:
            return [:]
        }
    }
    
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
        print(url ?? "")
        
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = resource.header(token: "d11bcb361e17fc5272675f5d2fc9d33dbf20e6312019c0a50a7c30bd5d6b1ba6")
        request.httpMethod = resource.httpMethod().rawValue
        
        session.dataTask(with: request) { (data, res, err) in
            if let data = data {
                switch resource {
                case .posts:
                    let postList = try? JSONDecoder().decode(PostsLists.self, from: data)
                    guard let posts = postList?.posts else { return }
                    print("do something")
                    return completion(posts)
                    
                case .comments:
                    let commentList = try? JSONDecoder().decode(CommentsList.self, from: data)
                    guard let comments = commentList?.comments else { return }
                    print("do something else")
                    return completion(comments)
                }
            }
        }.resume()
    }
    
//    func fetchPost(completion: @escaping ([Post]) -> ()) {
//        let productUrl = URL(string: baseURL.appending("posts/all"))
//        var request = URLRequest(url: productUrl!)
//
//        request.allHTTPHeaderFields = headerField(authorization: "d11bcb361e17fc5272675f5d2fc9d33dbf20e6312019c0a50a7c30bd5d6b1ba6")
//
//        session.dataTask(with: request) { (data, response, err) in
//
//            if let data = data {
//                let postList = try? JSONDecoder().decode(PostsLists.self, from: data)
//                guard let posts = postList?.posts else { return }
////                print("do something")
//                return completion(posts)
//            }
//        }.resume()
//    }
//
//
//
//
//    func fetchComment(postId: Int, completion: @escaping ([Comment]) -> ()) {
////        print("fetch this shit!")
//        let path = "posts/\(postId)/comments"
//        let commentUrl = URL(string: baseURL.appending(path))
//        var request = URLRequest(url: commentUrl!)
//
//        request.allHTTPHeaderFields = headerField(authorization: "d11bcb361e17fc5272675f5d2fc9d33dbf20e6312019c0a50a7c30bd5d6b1ba6")
//        session.dataTask(with: request) { (data, respinse, err) in
//
//            if let data = data {
//                let commentList = try? JSONDecoder().decode(CommentsList.self, from: data)
//                guard let comments = commentList?.comments else { return }
//                print("do something else")
//                return completion(comments)
//            }
//        }.resume()
//    }
}




















