//
//  PackageListViewModel.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import Foundation

class PackageListViewModel {
    private let networkLayer = NetworkLayer()
    
    func fetch() {
        networkLayer.request(model: PackageDataModel.self,
                             apiURL: .packageList) { [weak self] result in
            print(result)
        }
    }
}
