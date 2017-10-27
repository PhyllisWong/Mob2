//
//  JokeViewController.swift
//  parsingJSON
//
//  Created by djchai on 10/27/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

struct Joke {
    let id: Int
    let type: String
    let setup: String
    let punchline: String

    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        type = json["type"] as? String ?? ""
        setup = json["setup"] as? String ?? ""
        punchline = json["punchline"] as? String ?? ""
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonURLString = "https://08ad1pao69.execute-api.us-east-1.amazonaws.com/dev/random_joke"
        guard let url = URL(string: jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//                print(json)
                let joke = Joke(json: json)
                print(joke.punchline)
                
            }
            catch let jsonErr {
                print("error serializing json:", jsonErr)
            }
        }.resume()
    }
    
}



