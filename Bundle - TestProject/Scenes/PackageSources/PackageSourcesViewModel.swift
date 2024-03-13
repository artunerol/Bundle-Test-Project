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
    var parentPackageID: Int = 0
    var selectedSources: [Int] = []
    lazy var userdefaultsKey: String = {
        return UserdefaultsKeys.selectedSourceIDs + "\(parentPackageID)"
    }()
    
    let packageSourceResponse: BehaviorRelay<[PackageSourceModel]?> = .init(value: nil)
    let requestError: BehaviorRelay<CustomError> = .init(value: .defaultError) //This error should be handled in reality
    
    func fetchSources() {
        networkLayer.request(model: [PackageSourceModel].self,
                             apiURL: .packageSource(id: parentPackageID)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.packageSourceResponse.accept(response)
            case .failure(let error):
                self?.requestError.accept(error)
            }
        }
    }
}
