//
//  PackageListViewModel.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import Foundation
import RxSwift
import RxCocoa

class PackageListViewModel {
    private let networkLayer = NetworkLayer()
    let packageListResponse: BehaviorRelay<PackageDataModel?> = .init(value: nil)
    let requestError: BehaviorRelay<CustomError> = .init(value: .defaultError)
    
    func fetch() {
        networkLayer.request(model: PackageDataModel.self,
                             apiURL: .packageList) { [weak self] result in
            switch result {
            case .success(let response):
                self?.packageListResponse.accept(response)
            case .failure(let error):
                self?.requestError.accept(error)
            }
        }
    }
}
