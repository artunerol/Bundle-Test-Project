//
//  PackageTableViewCellViewModel.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 12.03.2024.
//

import Foundation
import RxSwift
import RxCocoa

class PackageTableViewCellViewModel {
    let isCellSelectedRelay: BehaviorRelay<Bool> = .init(value: false)
}
