//
//  PackageSourceCellModel.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 12.03.2024.
//

import Foundation

class PackageSourceCellModel {
    var selectedSourcesIDs: [Int] {
        guard let selectedSourcesIDs = UserDefaults.standard.object(forKey: UserdefaultsKeys.selectedSourceIDs) as? [Int] else { return [] }
        
        return selectedSourcesIDs
    }
}
