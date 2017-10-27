//
//  ViewController.swift
//  parsingJSON
//
//  Created by djchai on 10/26/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

struct Country : Decodable {
    let name : String
    let capitol : String
    let region : String
}

class ViewController: UIViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let jsonURL = "https://api.letsbuildthatapp.com/jsondecodable/course"
        let url = URL(string: jsonURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            do {
               
                self.countries = try JSONDecoder().decode([Country].self, from: data!)
                for eachCountry in self.countries {
                    print(eachCountry.name)
                }
                
            }
            catch {
                print("error")
            }
        }.resume()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

