//
//  PackageListViewController.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class PackageListViewController: BaseViewController {
    private let viewModel = PackageListViewModel()
    private let disposeBag = DisposeBag()
    
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
        bind()
        viewModel.fetch()
    }
}

// MARK: - Rx Bindings

extension PackageListViewController {
    private func bind() {
        bindPackageListResponse()
        bindError()
    }
    
    private func bindPackageListResponse() {
        viewModel
            .packageListResponse
            .observe(on: MainScheduler.instance)
            .skip(1)
            .bind(onNext: { [weak self] resultResponse in
                guard let self = self else { return }
                self.packageListTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindError() {
        viewModel
            .requestError
            .observe(on: MainScheduler.instance)
            .skip(1)
            .bind(onNext: { [weak self] error in
                guard let _ = self else { return }
                switch error {
                case .requestError(error: let error):
                    print("Handle Request Error. Description: \(error.localizedDescription)")
                case .throwError:
                    print("Handle Throw Error")
                case .defaultError:
                    print("Handle Default error")
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableview delegate & DataSource

extension PackageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PackageListTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.packageListResponse.value?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageListTableViewCell.identifer,for: indexPath) as? PackageListTableViewCell else { return UITableViewCell() }
        let packageListItem = viewModel.packageListResponse.value?.data ?? []
        cell.configure(with: packageListItem[indexPath.row])
        
        return cell
    }
}
