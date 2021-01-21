

import UIKit

class DetailsCollectionViewController: UICollectionViewController {
    
    var albums: [Album] = []
    var photos: [Photo] = []
    
    var userAlbums: [Album] = []
    var userPhotos: [Photo] = []
    
    var userId: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchAlbums(for: userId.id) { albums in
            self.albums = albums
            for album in albums {
                if album.userId == self.userId.id {
                    self.userAlbums.append(album)
                    print(self.userAlbums)
                }
            }
        }
        
        NetworkManager.shared.fetchPhotos(for: userAlbums.first?.id ?? 0 ) { photos in
            DispatchQueue.main.async { [self] in
                self.photos = photos
                for photo in photos {
                    if photo.albumId == userAlbums.first?.id {
                        userPhotos.append(photo)
                    }
                }
                self.collectionView.reloadData()
            }
        }
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
}

extension DetailsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 350)
    }
}

extension UIView {
    
    func customView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1.5
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize.zero
        self.clipsToBounds = false
    }
}
