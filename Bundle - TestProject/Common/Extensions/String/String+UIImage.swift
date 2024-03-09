//
//  String+UIImage.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import UIKit

extension String {
    func getImage(completion: @escaping (UIImage?) -> Void) {
        // URL session used instead in need of async image process
        
        let request = URLRequest(url: self.convertToURL())
        let _ = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let dataUnwrapped = data else { return }
            completion(UIImage(data: dataUnwrapped))
        }.resume()
    }
}
