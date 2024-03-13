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
    private let viewModel: PackageSourcesViewModel
    private let disposeBag = DisposeBag()
    
    @IBOutlet private var packageSourceTableView: UITableView! {
        didSet {
            packageSourceTableView.register(UINib(nibName: PackageSourceTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: PackageSourceTableViewCell.Constants.identifer)
            packageSourceTableView.delegate = self
            packageSourceTableView.dataSource = self
            packageSourceTableView.backgroundColor = .clear
        }
    }
    
    init(vm: PackageSourcesViewModel) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
        
        bind()
        viewModel.fetchSources()
        viewModel.selectedSources = UserDefaults.standard.getData(with: viewModel.userdefaultsKey,
                                                                  for: [Int].self) ?? []
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkIfAllSourcesSelected()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Tableview delegate & Datasource

extension PackageSourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PackageSourceTableViewCell.Constants.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.packageSourceResponse.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PackageSourceTableViewCell else { return }
        cell.didSelected()
        saveSelection(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageSourceTableViewCell.Constants.identifer,for: indexPath) as? PackageSourceTableViewCell else { return UITableViewCell() }
        let packageSourceItem = viewModel.packageSourceResponse.value ?? []
        cell.configure(with: packageSourceItem[indexPath.row])
        
        if viewModel.selectedSources.contains(where: {$0 == packageSourceItem[indexPath.row].id}) {
            cell.toggleSelection()
        }
        return cell
    }
}

// MARK: - Rx Bindings

extension PackageSourcesViewController {
    private func bind() {
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
}

// MARK: - Helpers
extension PackageSourcesViewController {
    private func saveSelection(for index: Int) {
        let selectionID = viewModel.packageSourceResponse.value?[index].id ?? 0
        
        if !viewModel.selectedSources.contains(where: {$0 == selectionID}) {
            //Add to selectedSources
            viewModel.selectedSources.append(selectionID)
            UserDefaults.standard.saveData(data: viewModel.selectedSources, key: viewModel.userdefaultsKey)
        } else {
            //Remove from selectedSources
            viewModel.selectedSources.removeAll(where: {$0 == selectionID})
            UserDefaults.standard.saveData(data: viewModel.selectedSources, key: viewModel.userdefaultsKey)
        }
    }
    
    private func checkIfAllSourcesSelected() {
        let sourceIDs = viewModel.packageSourceResponse.value?.map({$0.id})
        let selectedSourceIDs = viewModel.selectedSources
        
        if sourceIDs == selectedSourceIDs {
            print("asdkjnasdkjn")
        }
    }
}
