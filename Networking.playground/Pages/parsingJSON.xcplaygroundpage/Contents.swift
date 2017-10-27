//: [Previous](@previous)
import PlaygroundSupport
import UIKit

struct Pokemon : Decodable {
    let album : String
    let id : String
    let thumbnailUrl : String
}

//http://pokeapi.co/api/v2/pokemon/7/

class ViewController: UIViewController {
    
    var pokemons = [Pokemon]()

    override func viewDidLoad() {
        let jsonURL = "http://pokeapi.co/api/v2/pokemon/7/"
        let url = URL(string: jsonURL)
        
        URLSession.shared.dataTask(with: url!) { (data, resonse, error) in
            
            do {
                guard let data = data else {return}
                self.pokemons = try
                JSONDecoder().decode( [Pokemon].self, from: data)
                for eachItem in self.pokemons {
                    print(eachItem.album)
                }
            }
            catch {
                print("error")
            }
            
        }.resume()
    }
   
}

PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
