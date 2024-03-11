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
            packageListTableView.register(UINib(nibName: PackageTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: PackageTableViewCell.identifer)
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
        bindLoadingStatus()
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
    
    private func bindLoadingStatus() {
        viewModel
            .showLoadingStatus
            .observe(on: MainScheduler.instance)
            .skip(1)
            .bind { [weak self] isLoading in
                self?.toggleLoading(isLoading)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableview delegate & DataSource

extension PackageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PackageTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.packageListResponse.value?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedPackage = tableView.cellForRow(at: indexPath) as? PackageTableViewCell else { return }
        navigationRouter.navigate(toVC: .packageSource(id: selectedPackage.model?.id ?? 0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.identifer,for: indexPath) as? PackageTableViewCell else { return UITableViewCell() }
        let packageListItemArray = viewModel.packageListResponse.value?.data ?? []
        let item = packageListItemArray[indexPath.row]
        cell.configure(with: item, type: .packageList)
        
        return cell
    }
}
