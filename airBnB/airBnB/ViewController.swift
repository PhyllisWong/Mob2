//
//  ViewController.swift
//  airBnB
//
//  Created by djchai on 10/29/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

struct Listing {
    let bedrooms : Int
    let city : String
//    let firstName : String
    
    init (bedrooms: Int, city: String) {
        self.bedrooms = bedrooms
        self.city = city
//        self.firstName = firstName
    }
}

struct SearchResults: Decodable {
    let search_results : [Listing]
}

extension Listing: Decodable {
    
    // declaring our keys
    enum TopLevelKeys: String, CodingKey {
        case listing
    }
    
    enum ListingKeys: String, CodingKey {
        case bedrooms
        case city
//        case primary_host
    }
    
//    enum PrimaryHostKeys: String, CodingKey {
//        case first_name
//    }
    
    
    
    init(from decoder: Decoder) throws {
        // defining our (keyed) container
        let container = try decoder.container(keyedBy: TopLevelKeys.self)
        
        // Listing Container
        let listingContainer = try container.nestedContainer(keyedBy: ListingKeys.self, forKey: .listing)
        
        let bedrooms: Int = try listingContainer.decodeIfPresent(Int.self, forKey: .bedrooms) ?? 1
        let city: String = try listingContainer.decodeIfPresent(String.self, forKey: .city) ?? ""
//        let primary_host: [String] = try listingContainer.decodeIfPresent([String].self, forKey: .primary_host) ?? [""]
        
//        // Primary Host Container
//        let primaryHostContainer = try listingContainer.nestedContainer(keyedBy: primary_host.self, forKey: .first_name)
        self.init(bedrooms: bedrooms, city: city)

    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonURLString = "https://api.airbnb.com/v2/search_results?api_key=915pw2pnf4h1aiguhph5gc5b2"
        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode([SearchResults].self, from: data)
                print(searchResult)
            }
            catch let jsonErr {
                print("Error fetching json: ", jsonErr)
            }
            
        }.resume()
        let listing = Listing(bedrooms: 1, city: "Ostuni")
        print(listing)
    }
    

}

