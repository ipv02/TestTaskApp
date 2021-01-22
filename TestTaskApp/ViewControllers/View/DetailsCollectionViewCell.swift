

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IB Outlets
    @IBOutlet weak var photoUser: ImageView!
    @IBOutlet weak var namePhoto: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Public Methods
    func configureCell(with photo: Photo) {
        namePhoto.text = photo.title
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.stopAnimating()
            self.photoUser.fetchImage(from: photo.url ?? "")
        }
    }
}
