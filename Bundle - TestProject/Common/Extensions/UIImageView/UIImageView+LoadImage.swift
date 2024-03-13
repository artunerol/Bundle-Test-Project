//
//  UIImageView+LoadImage.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 10.03.2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageWith(urlString: String) {
        let cache = AppCache.shared.cache
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if let cacheImage = cache.object(forKey: NSString(string: urlString)) { //Setting cache key same as url.
                DispatchQueue.main.async {
                    self.image = cacheImage as? UIImage
                }
                return
            } else {
                let request = URLRequest(url: urlString.convertToURL())
                let _ = URLSession.shared.dataTask(with: request) { data, _, _ in
                    guard let dataUnwrapped = data,
                          let imageUnwrapped = UIImage(data: dataUnwrapped) else { return }
                    
                    cache.setObject(imageUnwrapped, forKey: NSString(string: urlString))
                    DispatchQueue.main.async {
                        self.image = imageUnwrapped
                    }
                }.resume()
            }
        }
    }
}
