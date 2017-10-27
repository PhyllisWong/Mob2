//
//  jsonParsonDecodableViewController.swift
//  parsingJSON
//
//  Created by djchai on 10/27/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

//struct Course {
//    let id : Int
//    let name : String
//    let link : String
//    let imageURL: String
//}

struct Pokemon {
    let <#name#> = <#value#>
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonURLString = "http://pokeapi.co/api/v2/pokemon/7/"
//        let jsonURLString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        guard let url = URL(string: jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
//            if let dataAsString = String(data: data, encoding: .utf8) {
//                print(dataAsString)
//            }
            
            do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print(json)
            }
            catch {
                print("ERROR")
            }
            
            
        }.resume()
        

//        let myCourse = Course(id: 1, name: "my course", link: "some link", imageURL: "some image url")
//        print(myCourse)
    }

 

}
