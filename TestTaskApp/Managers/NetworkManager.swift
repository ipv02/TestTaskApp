

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetchUsers(from urlString: String, completion: @escaping ([User]) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode([User].self, from: data)
                completion(user)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
//    func fetchAlbums(from urlString: String, completion: @escaping ([Album]) -> Void) {
//
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error { print(error); return }
//
//            guard let data = data else { return }
//
//            do {
//                let albums = try JSONDecoder().decode([Album].self, from: data)
//                completion(albums)
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }
//
//    func fetchPhotos(from urlString: String, completion: @escaping ([Photo]) -> Void) {
//
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error { print(error); return }
//
//            guard let data = data else { return }
//
//            do {
//                let photos = try JSONDecoder().decode([Photo].self, from: data)
//                completion(photos)
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }
    
    func fetchAlbums(for: Int, completion: @escaping ([Album]) -> Void) {
        
        let urlStringAlbums = "https://jsonplaceholder.typicode.com/albums"

        guard let url = URL(string: urlStringAlbums) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }

            guard let data = data else { return }

            do {
                let albums = try JSONDecoder().decode([Album].self, from: data)
                completion(albums)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchPhotos(for: Int, completion: @escaping ([Photo]) -> Void) {
        
        let urlStringPhotos = "https://jsonplaceholder.typicode.com/photos"
        
        guard let url = URL(string: urlStringPhotos) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            
            guard let data = data else { return }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(photos)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
