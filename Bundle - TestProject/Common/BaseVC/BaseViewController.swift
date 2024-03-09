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
        view.backgroundColor = AppColor.background.getColor()
        setNavigationBackBarButton()
    }
    
    private func setNavigationBackBarButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "") // Removing BackButton titles from every VC inside Navigation Stack
        edgesForExtendedLayout = .top // Stretches viewcontroller over navigationbar
    }
}
