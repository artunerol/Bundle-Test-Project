//
//  PackageListViewController.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import UIKit

class PackageListViewController: BaseViewController {

    @IBAction func testButtonPressed(_ sender: Any) {
        navigationRouter.navigate(toVC: .packageSource)
    }
}
