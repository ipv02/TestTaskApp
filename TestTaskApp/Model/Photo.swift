

import Foundation

struct Photo: Decodable, FilterProtocol {
    
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    
    var idForFilter: Int { return albumId ?? 0 }
}
