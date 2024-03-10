//
//  UIImageView+LoadImage.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 10.03.2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageWith(url: URL, cacheID: Int) {
        let imageCache = NSCache<NSNumber, UIImage>()
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if let cacheImage = imageCache.object(forKey: NSNumber(integerLiteral: cacheID)) {
                DispatchQueue.main.async {
                    self.image = cacheImage
                }
                return
            } else {
                let request = URLRequest(url: url)
                let _ = URLSession.shared.dataTask(with: request) { data, _, _ in
                    guard let dataUnwrapped = data,
                          let imageUnwrapped = UIImage(data: dataUnwrapped) else { return }
                    
                    imageCache.setObject(imageUnwrapped, forKey: NSNumber(integerLiteral: cacheID))
                    DispatchQueue.main.async {
                        self.image = imageUnwrapped
                    }
                }.resume()
            }
        }
    }
}
