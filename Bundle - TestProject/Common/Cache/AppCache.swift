//
//  AppCache.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 10.03.2024.
//

import UIKit

class AppCache {
    static let shared = AppCache()
    
    let cache = NSCache<NSString, AnyObject>()
}
