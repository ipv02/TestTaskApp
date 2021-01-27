

import UIKit

class DetailsCollectionViewController: UICollectionViewController {

    //MARK: - Public Properties
    var userId: User!
    
    // MARK: - Private Properties
    private let urlStringAlbums = "https://jsonplaceholder.typicode.com/albums"
    private let urlStringPhotos = "https://jsonplaceholder.typicode.com/photos"
    
    private var albums: [Album] = []
    private var photos: [Photo] = []
    
    private var userAlbums: [Album] = []
    private var userPhotos: [Photo] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbumsAndPhotos()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! DetailsCollectionViewCell
        
        let photo = userPhotos[indexPath.item]
        cell.configureCell(with: photo)

        cell.customView()
        
        return cell
    }
    
    //MARK: - Private Methods
    private func fetchAlbumsAndPhotos() {
        
        NetworkManager.shared.fetchAlbums(from: urlStringAlbums) { [unowned self] albums in
            self.albums = albums
            let filteredAlbums = filterData(array: albums, id: userId.id ?? 0)
            userAlbums.append(contentsOf: filteredAlbums)
        }
        
        NetworkManager.shared.fetchPhotos(from: urlStringPhotos) { photos in
            DispatchQueue.main.async { [unowned self] in
                self.photos = photos
                let albumId = userAlbums.first?.id
                let filteredPhotos = filterData(array: photos, id: albumId ?? 0)
                userPhotos.append(contentsOf: filteredPhotos)
                
                collectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 350)
    }
}
