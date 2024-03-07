//
//  NavigationRouter.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import UIKit

class NavigationRouter {
    var baseNC: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.baseNC = navigationController
    }
    
    func navigate(toVC: NavigationEnum,
                  navigationType: NavigationType = .push) {
        switch navigationType {
        case .present:
            baseNC.present(toVC.getViewController(), animated: true)
        case .push:
            baseNC.pushViewController(toVC.getViewController(), animated: true)
        }
    }
}

// MARK: - NavigationEnum & Type

enum NavigationEnum {
    // NavigationEnum is adding a control layer over ViewControllers since Enums should be exhaustive.
    case packageList
    case packageSource
    
    func getViewController() -> UIViewController {
        switch self {
        case .packageList:
            PackageListViewController()
        case .packageSource:
            PackageSourcesViewController()
        }
    }
}

enum NavigationType {
    // Navigation Types can be added to provide variety
    case push
    case present
}
