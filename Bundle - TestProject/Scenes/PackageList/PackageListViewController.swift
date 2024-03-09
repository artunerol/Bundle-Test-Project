//
//  PackageListViewController.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import UIKit

class PackageListViewController: BaseViewController {
    private let viewModel = PackageListViewModel()
    
    @IBOutlet var packageListTableView: UITableView! {
        didSet {
            packageListTableView.register(UINib(nibName: PackageListTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: PackageListTableViewCell.identifer)
            packageListTableView.delegate = self
            packageListTableView.dataSource = self
            
            packageListTableView.backgroundColor = .clear
            packageListTableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
    }
}

// MARK: - UITableview delegate & DataSource

extension PackageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PackageListTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageListTableViewCell.identifer,for: indexPath) as? PackageListTableViewCell else { return UITableViewCell() }
        cell.configure(with: PackageModel(id: 12,
                                          isAdded: true,
                                          description: "This is my description This is my description This is my description This is my description This is my description This is my description This is my description This is my description This is my description",
                                          image: "https://static.bundle.app/contentChannel/packages/cugnfl0t.uv5.png",
                                          style: PackageStyleModel(fontColor: "#ffffff")))
        return cell
    }
}
