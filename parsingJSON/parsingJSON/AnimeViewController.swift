import UIKit
//import PlaygroundSupport

struct Anime {
    let title: String
    let thumbnail: URL
    let id: String
    
    init(title: String, thumbnail: URL, id: String) {
        self.title = title
        self.thumbnail = thumbnail
        self.id = id
    }
}

extension Anime : Decodable {
    // declaring our keys
    
    enum TopLevelKeys: String, CodingKey {
        case id
        case attributes
    }
    
    enum TitleKeys: String, CodingKey {
        case en = "en"
        case en_jp
    }
    
    enum AttributeKeys: String, CodingKey {
        case titles
        case posterImage
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case thumbnail = "original"
    }
    
    init(from decoder: Decoder) throws {
        // defining our (keyed) container
        let container = try decoder.container(keyedBy: TopLevelKeys.self)
        
        // Id - top level in data array
        let id: String = try container.decode(String.self, forKey: .id)
        
        // Attributes Container
        let attributesContainer = try container.nestedContainer(keyedBy: AttributeKeys.self, forKey: .attributes)
        
        // Container holding title
        let titlesContainer = try attributesContainer.nestedContainer(keyedBy: TitleKeys.self, forKey: .titles)
        
        let title: String = try titlesContainer.decodeIfPresent(String.self, forKey: .en) ?? ""
       
        
        // Poster Image
        let thumbnailContainer = try attributesContainer.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .posterImage)
        //
        let thumbnail: URL = try thumbnailContainer.decode(URL.self, forKey: .thumbnail)
        
        self.init(title: title, thumbnail: thumbnail, id: id)
    }
}

struct AnimeList: Decodable {
    let data: [Anime]
}

typealias JSON = [String: Any]

class ViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
    

        class Networking {
            // bind the url to a variable of type URL(String: string)
            let jsonURLString = URL(string: "https://kitsu.io/api/edge/anime")!
            
            func getAnime(id: String, completion: @escaping ([Anime]) -> Void) {
                
                // Create the URLSession closure passing in the unwrapped jsonURLString
                URLSession.shared.dataTask(with: jsonURLString) { (data, resp, err) in
                    
                    guard let data = data else { return }
                    let animeList = try? JSONDecoder().decode(AnimeList.self, from: data)
                    guard let animes = animeList?.data else { return }
                    print(animes)
                    
                }.resume()
            }
        }
            let anime = Anime(title: "Cowboy Bebop", thumbnail: URL(string: "https://media.kitsu.io/anime/poster_images/1/original.jpg?1431697256")!, id: "1")
            print(anime.id)
            print(anime.thumbnail)
    }
    
}




