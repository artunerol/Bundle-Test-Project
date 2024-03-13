//
//  PackageSourceModel.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 12.03.2024.
//

import Foundation

class PackageSourceModel: Codable {
    let id: Int?
    let isAdded: Bool?
    let name: String?
    
    init(id: Int? = nil,
         isAdded: Bool? = nil,
         name: String? = nil) {
        self.id = id
        self.isAdded = isAdded
        self.name = name
    }
}
