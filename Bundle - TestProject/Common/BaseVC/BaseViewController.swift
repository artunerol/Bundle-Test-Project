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
    
    private var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setNavigationBar()
    }
    
    private func setupView() {
        view.backgroundColor = AppColor.background.getColor()
        view.addSubview(spinner)
        setupSpinner()
    }
    
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = .white
        spinner.style = .large
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setNavigationBar() {
        let icon = UIImage(named: "bundle_icon")
        let imageView = UIImageView(image:icon)
        imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "") // Removing BackButton titles from every VC inside Navigation Stack
        edgesForExtendedLayout = .top // Stretches viewcontroller over navigationbar
    }
}

// MARK: - LoadingStatus

extension BaseViewController {
    func toggleLoading(_ toggle: Bool) {
        if toggle {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
}
