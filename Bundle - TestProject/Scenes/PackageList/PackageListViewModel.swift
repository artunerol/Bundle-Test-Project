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
    let showLoadingStatus: BehaviorRelay<Bool> = .init(value: false)
    let packageListResponse: BehaviorRelay<PackageDataModel?> = .init(value: nil)
    let requestError: BehaviorRelay<CustomError> = .init(value: .defaultError)
    
    func fetch() {
        showLoadingStatus.accept(true)
        networkLayer.request(model: PackageDataModel.self,
                             apiURL: .packageList) { [weak self] result in
            switch result {
            case .success(let response):
                self?.packageListResponse.accept(response)
                self?.showLoadingStatus.accept(false)
            case .failure(let error):
                self?.requestError.accept(error)
                self?.showLoadingStatus.accept(false)
            }
        }
    }
}
