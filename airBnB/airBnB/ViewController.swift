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
    let firstName : String
}

struct Search: Decodable {
    // Everything in this struct is to access the listing container
    let searchResults : [Listing]
    
    enum SearchResultKey: String, CodingKey {
        case searchResults = "search_results"
    }
    // need init to change from their "search_result" snake_case to swift camelCase
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchResultKey.self)
        let listings = try? container.decode([Listing].self, forKey: .searchResults)
        self.searchResults = listings!
        
    }
}

extension Listing: Decodable {
    
    // declaring our keys
    enum SearchResultKeys: String, CodingKey {
        case listing
    }
    
    enum ListingKeys: String, CodingKey {
        case bedrooms
        case city
        case primaryHost = "primary_host"
    }
    
    enum PrimaryHostKeys: String, CodingKey {
        case firstName = "first_name"
    }
    
    
    
    init(from decoder: Decoder) throws {
        // defining our (keyed) container
        let container = try decoder.container(keyedBy: SearchResultKeys.self)
        
        // Listing Container
        let listingContainer = try container.nestedContainer(keyedBy: ListingKeys.self, forKey: .listing)
        
        let bedrooms: Int = try listingContainer.decodeIfPresent(Int.self, forKey: .bedrooms) ?? 1
        let city: String = try listingContainer.decodeIfPresent(String.self, forKey: .city) ?? ""
        
        // Primary Host Container
        let primaryHostContainer = try listingContainer.nestedContainer(keyedBy: PrimaryHostKeys.self, forKey: .primaryHost)
        let firstName = try primaryHostContainer.decode(String.self, forKey: .firstName)
        
        self.init(bedrooms: bedrooms, city: city, firstName: firstName)

    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonURLString = "https://api.airbnb.com/v2/search_results?api_key=915pw2pnf4h1aiguhph5gc5b2"
        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let data = data {
                let resultsList = try? JSONDecoder().decode(Search.self, from: data)
                guard let listing = resultsList?.searchResults else { return }
                dump(listing)
                dump(listing[5].firstName)
                dump(listing[14].city)
            }
            
        }.resume()
        
    }
    

}

