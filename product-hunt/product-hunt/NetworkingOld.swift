//
//  NetworkingOld.swift
//  product-hunt
//
//  Created by djchai on 11/6/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

//import Foundation

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
