

import UIKit


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
