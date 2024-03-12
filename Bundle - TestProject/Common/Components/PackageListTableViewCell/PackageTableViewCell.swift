//
//  PackageListTableViewCell.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class PackageTableViewCell: UITableViewCell {
    struct Constants {
        static let height: CGFloat = 120
        static let identifer: String = "PackageListTableViewCell"
    }
    
    private let viewModel = PackageTableViewCellViewModel()
    private let disposeBag = DisposeBag()
    
    var packageModel = PackageModel()
    
    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .white
            descriptionLabel.font = AppFont.description.getFont()
        }
    }
    
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var selectionButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentView()
    }
    
    func configure(with model: PackageModel, type: PackageType) {
        switch type {
        case .packageList:
            thumbnailImageView.isHidden = false
            thumbnailImageView.loadImageWith(urlString: model.image ?? "")
            descriptionLabel.text = model.description
            descriptionLabel.textColor = UIColor(hex: model.style?.fontColor ?? "") //Getting fontColor from API
        case .packageSource:
            thumbnailImageView.isHidden = true
            descriptionLabel.text = model.name
        }
        
        self.packageModel = model
        configureSelectionButton(with: viewModel.isCellSelectedRelay.value)
    }
}

// MARK: - CellDidSelected

extension PackageTableViewCell {
    func didSelected() {
        var isSelected = viewModel.isCellSelectedRelay.value
        isSelected.toggle()
        
        viewModel.isCellSelectedRelay.accept(isSelected)
        configureSelectionButton(with: isSelected)
        animateSelection()
    }
    
    private func getSelectedSource() {
        let selectedSourcesIDs = UserDefaults.standard.object(forKey: UserdefaultsKeys.selectedSourceIDs) as? [Int]
        
//        if selectedSourcesIDs?.contains(where: { [weak self] sourceID in
//            sourceID == self?.packageModel.id
//        })
    }
    
    private func saveSelectedSource() {
        
    }
}

// MARK: - Helpers
extension PackageTableViewCell {
    private func setupContentView() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10,
                                                                     left: 0,
                                                                     bottom: 10,
                                                                     right: 0))
        
        contentView.backgroundColor = AppColor.primary.getColor()
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowColor = UIColor.white.cgColor
        
        contentView.layer.cornerRadius = 8
    }
    
    private func configureSelectionButton(with isAdded: Bool) {
        if isAdded {
            selectionButton.setImage(UIImage(systemName: "checkmark.square.fill"),
                                     for: .normal)
        } else {
            selectionButton.setImage(UIImage(systemName: "square"),
                                     for: .normal)
        }
    }
    
    private func animateSelection() {
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }, completion: { [weak self] completed in
            if completed {
                UIView.animate(withDuration: 0.1) {
                    self?.transform = .identity
                }
            }
        })
    }
}

enum PackageType {
    case packageList
    case packageSource
}
