//
//  PackageListTableViewCell.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class PackageListTableViewCell: UITableViewCell {
    struct Constants {
        static let height: CGFloat = 120
        static let identifer: String = "PackageListTableViewCell"
    }
    
    private let disposeBag = DisposeBag()
    var packageModel = PackageModel()
    
    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = AppFont.description.getFont()
        }
    }
    
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var selectionButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentView()
    }
    
    func configure(with model: PackageModel) {
        self.packageModel = model
        
        thumbnailImageView.isHidden = false
        thumbnailImageView.loadImageWith(urlString: model.image ?? "")
        descriptionLabel.text = model.description
        descriptionLabel.textColor = UIColor(hex: model.style?.fontColor ?? "") //Getting fontColor from API
        
        configureSelectionButton(with: model.isAdded)
    }
    
    func configureSelectionUI() {
        selectionButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }
}

// MARK: - Helpers
extension PackageListTableViewCell {
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
}
