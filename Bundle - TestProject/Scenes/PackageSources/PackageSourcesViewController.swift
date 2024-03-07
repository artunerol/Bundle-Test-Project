//
//  PackageSourcesViewController.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import UIKit

class PackageSourcesViewController: BaseViewController {

    @IBAction func testButtonTapped(_ sender: Any) {
        navigationRouter.navigate(toVC: .packageList)
    }
}
