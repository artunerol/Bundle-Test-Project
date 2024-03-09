//
//  PackageModel.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import Foundation

struct PackageModel: Codable {
    let id: Int
    let isAdded: Bool
    let description: String
    let image: String
    let style: PackageStyleModel
}

struct PackageStyleModel: Codable {
    let fontColor: String
}
