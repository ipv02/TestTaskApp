

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoUser: UIImageView!
    @IBOutlet weak var namePhoto: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func configureCell(with photo: Photo) {
        namePhoto.text = photo.title
        DispatchQueue.global().async {
            guard let stringURL = photo.url else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.activityIndicator.hidesWhenStopped = true
                self.activityIndicator.stopAnimating()
                self.photoUser.image = UIImage(data: imageData)
            }
        }
    }
}
