//  networking.swift
//  practiceAPI
//
//  Created by djchai on 11/20/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

/*
 Parts of the HTTP Request
 1. Request Method: GET, PUT, DELETE or POST
 2. Header
 3. URL Path
 4. URL Parameters
 5. Body
 */

enum HTTPMethod: String {
    case post = "POST"
}

enum Resource: Decodable {
   
    case getLocation
    
    func httpMethod() -> HTTPMethod {
        switch self {
        case .getLocation:
            return .post
        }
    }
    
    init(from decoder: Decoder) throws {
        <#code#>
    }
}

class networking: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}


