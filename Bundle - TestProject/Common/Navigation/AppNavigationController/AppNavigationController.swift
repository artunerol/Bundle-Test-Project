//
//  AppNavigationController.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNavigationController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension AppNavigationController {
    private func setupNavigationController() {
        navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navigationBar.tintColor = .blue
    }
}
