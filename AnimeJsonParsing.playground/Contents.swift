import UIKit
import PlaygroundSupport

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
        
        // Attributes Container
        let attributesContainer = try container.nestedContainer(keyedBy: AttributeKeys.self, forKey: .attributes)
        
        // Container holding title
        let titlesEnContainer = try attributesContainer.nestedContainer(keyedBy: TitleKeys.self, forKey: .titles)
        
        let title: String = try titlesEnContainer.decodeIfPresent(String.self, forKey: .en) ?? ""
        
        // Id - top level in data array
        let id: String = try container.decode(String.self, forKey: .id)
        
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

let networking = Networking()
networking.getAnime(id: "1") { (res) in
    print(res)
}

//let networking2 = Networking()
//networking2.getAnime(id: <#T##String#>, completion: <#T##([Anime]) -> Void#>)








