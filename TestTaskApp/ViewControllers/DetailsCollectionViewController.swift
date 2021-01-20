

import UIKit

class DetailsCollectionViewController: UICollectionViewController {
    
    private let urlStringAlbums = "https://jsonplaceholder.typicode.com/albums"
    private let urlStringPhotos = "https://jsonplaceholder.typicode.com/photos"
    
    var albums: [Album] = []
    var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchPhotos(from: urlStringPhotos) { photos in
            DispatchQueue.main.async {
                self.photos = photos
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! DetailsCollectionViewCell
        
        let photo = photos[indexPath.item]
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
