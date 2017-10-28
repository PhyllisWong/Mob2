////
////  AnimeViewController.swift
////  parsingJSON
////
////  Created by djchai on 10/27/17.
////  Copyright © 2017 Phyllis Wong. All rights reserved.
////
//
//import UIKit
//
//struct Anime : Decodable {
//    let id : Int
////    let titles : String
////    let image : URL
//}
//
//struct TopLevel : Decodable {
//    let topLevel : [String : Any]
//}
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let jsonURLString = "https://kitsu.io/api/edge/anime"
//        guard let url = URL(string: jsonURLString) else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else { return }
//            
//            do {
//                let topLevel = JSONDecoder.decode([TopLevel].self, from: data)
//            }
//            catch let jsonErr {
//                print("error: ", jsonErr)
//            }
//        }.resume()
//        
//    }
//
//}

