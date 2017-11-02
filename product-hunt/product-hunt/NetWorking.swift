//
//  NetWorking.swift
//  product-hunt
//
//  Created by djchai on 11/1/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation

class Networking {
    let session = URLSession.shared
    let baseURL = "https://api.producthunt.com/v1/posts/all"
    
    func headerField(authorization: String) -> [String : String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authorization)",
            "Host": "api.producthunt.com"
        ]
    }

    func fetchPost(completion: @escaping ([Post]) -> ()) {
        let productUrl = URL(string: baseURL)
        var request = URLRequest(url: productUrl!)
        request.allHTTPHeaderFields = headerField(authorization: "d11bcb361e17fc5272675f5d2fc9d33dbf20e6312019c0a50a7c30bd5d6b1ba6")
        
        session.dataTask(with: request) { (data, response, err) in
            
            if let data = data {
                let postList = try? JSONDecoder().decode(PostsLists.self, from: data)
                guard let posts = postList?.posts else { return }
                print("do something")
                return completion(posts)
            }
        }.resume()
    }
}




















