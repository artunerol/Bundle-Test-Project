//
//  PackageSourcesViewController.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 7.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class PackageSourcesViewController: BaseViewController {
    private let viewModel = PackageSourcesViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet private var packageSourceTableView: UITableView! {
        didSet {
            packageSourceTableView.register(UINib(nibName: PackageTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: PackageTableViewCell.identifer)
            packageSourceTableView.delegate = self
            packageSourceTableView.dataSource = self
            packageSourceTableView.backgroundColor = .clear
        }
    }
    
    init(id: Int) {
        super.init(nibName: nil, bundle: nil)
        bind()
        viewModel.fetchSources(with: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Tableview delegate & Datasource

extension PackageSourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PackageTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.packageSourceResponse.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.identifer,for: indexPath) as? PackageTableViewCell else { return UITableViewCell() }
        let packageSourceItem = viewModel.packageSourceResponse.value ?? []
        cell.configure(with: packageSourceItem[indexPath.row], type: .packageSource)
        
        return cell
    }
}

// MARK: - Rx Bindings

extension PackageSourcesViewController {
    private func bind() {
        bindLoadingStatus()
        bindPackageListResponse()
        bindError()
    }
    
    private func bindPackageListResponse() {
        viewModel
            .packageSourceResponse
            .observe(on: MainScheduler.instance)
            .skip(1)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.packageSourceTableView.reloadData()
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
