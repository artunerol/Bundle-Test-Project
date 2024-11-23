//
//  PackageModel.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import Foundation

struct PackageListModel: Codable {
    let data: [PackageModel]
}

struct PackageModel: Codable {
    let id: Int
    let isAdded: Bool
    let description: String?
    let image: String?
    let style: PackageStyleModel?
    
    init(id: Int = 0,
         isAdded: Bool = false,
         description: String? = nil,
         image: String? = nil,
         style: PackageStyleModel? = nil) {
        self.id = id
        self.isAdded = isAdded
        self.description = description
        self.image = image
        self.style = style
    }
}

struct PackageStyleModel: Codable {
    let fontColor: String
}
