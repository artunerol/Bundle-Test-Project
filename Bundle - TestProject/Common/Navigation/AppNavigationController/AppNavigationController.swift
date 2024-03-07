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
        configureRouter(for: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureRouter(for rootViewController: UIViewController) {
        if let rootVC = rootViewController as? BaseViewController {
            rootVC.navigationRouter.baseNC = self
        } else {
            
        }
    }
}

// MARK: - Helpers

extension AppNavigationController {
    private func setupNavigationController() {
        navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navigationBar.tintColor = .systemPink
    }
}
