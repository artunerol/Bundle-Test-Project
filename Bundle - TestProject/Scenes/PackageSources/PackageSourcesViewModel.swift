//
//  PackageSourcesViewModel.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import Foundation
import RxSwift
import RxCocoa

class PackageSourcesViewModel {
    private let networkLayer = NetworkLayer()
    
    let packageSourceResponse: BehaviorRelay<[PackageSourceModel]?> = .init(value: nil)
    let requestError: BehaviorRelay<CustomError> = .init(value: .defaultError) //This error should be handled in reality
    
    func fetchSources(with id: Int) {
        networkLayer.request(model: [PackageSourceModel].self,
                             apiURL: .packageSource(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.packageSourceResponse.accept(response)
            case .failure(let error):
                self?.requestError.accept(error)
            }
        }
    }
}
