

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Fetch Users
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        
        let urlStringUsers = "https://jsonplaceholder.typicode.com/users"
        
        guard let url = URL(string: urlStringUsers) else { return }
        
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
    
    //MARK: - Fetch Albums
    func fetchAlbums(for userId: Int, completion: @escaping ([Album]) -> Void) {
        
        let urlStringAlbums = "https://jsonplaceholder.typicode.com/albums"

        guard let url = URL(string: urlStringAlbums) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }

            guard let data = data else { return }

            do {
                let albums = try JSONDecoder().decode([Album].self, from: data)
                let albumsFiltered = self.filterAlbums(albums: albums, userId: userId)
                completion(albumsFiltered)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    //MARK: - Fetch Photos
    func fetchPhotos(for userId: Int, completion: @escaping ([Photo]) -> Void) {
        
        let urlStringPhotos = "https://jsonplaceholder.typicode.com/photos"
        
        guard let url = URL(string: urlStringPhotos) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            
            guard let data = data else { return }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                self.fetchAlbums(for: userId) { albums in
                    let albumId = albums.first?.id
                    let photoFiltered = self.filteredPhotos(photos: photos, albumId: albumId ?? 0)
                    completion(photoFiltered)
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

//MARK: - Filtered arrays Albums & Photos
extension NetworkManager {
    
    private func filterAlbums(albums: [Album], userId: Int) -> [Album] {
        var filteredAlbums: [Album] = []
        for album in albums {
            if album.userId == userId {
                filteredAlbums.append(album)
            }
        }
        return filteredAlbums
    }

    private func filteredPhotos(photos: [Photo], albumId: Int) -> [Photo] {
        var filteredPhotos: [Photo] = []
        for photo in photos {
            if photo.albumId == albumId {
                filteredPhotos.append(photo)
            }
        }
        return filteredPhotos
    }
}
