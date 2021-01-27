

import Foundation

struct Album: Decodable, FilterProtocol {
    
    let userId: Int?
    let id: Int?
    let title: String?
    
    var idForFilter: Int { return userId ?? 0}
}
