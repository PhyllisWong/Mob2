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

extension Anime {
    // declaring our keys
}
