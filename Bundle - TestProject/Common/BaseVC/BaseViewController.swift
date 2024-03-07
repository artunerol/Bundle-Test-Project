//
//  BaseViewController.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import UIKit

class BaseViewController: UIViewController {
    var navigationRouter: NavigationRouter {
        get { 
            // When navigationRouter is called from a VC, it will automatically addept to it's navigationController
            return NavigationRouter(navigationController: self.navigationController ?? UINavigationController())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBackBarButton()
    }
    
    private func setNavigationBackBarButton() {
        // Removing BackButton titles from every VC inside Navigation Stack
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
    }
}
