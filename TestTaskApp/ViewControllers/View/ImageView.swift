

import UIKit

class ImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else { image = #imageLiteral(resourceName: "picture"); return }
        if let cachedImage = getCachedImage(url: url) { image = cachedImage; return }
        
        ImageManager.shared.getImage(from: url) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            self.saveDataToCach(with: data, and: response)
        }
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveDataToCach(with data: Data, and response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
