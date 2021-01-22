

import UIKit

class DetailsCollectionViewController: UICollectionViewController {

    //MARK: - Public Properties
    var userId: User!
    
    // MARK: - Private Properties
    private var photos: [Photo] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbumsAndPhotos()
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
    
    private func fetchAlbumsAndPhotos() {
        NetworkManager.shared.fetchPhotos(for: userId.id) { photo in
            DispatchQueue.main.async {
                self.photos = photo
                self.collectionView.reloadData()
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

//MARK: - UIView
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
