//
//  PackageSourceTableViewCell.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 12.03.2024.
//

import UIKit

class PackageSourceTableViewCell: UITableViewCell {
    struct Constants {
        static let height: CGFloat = 120
        static let identifer: String = "PackageSourceTableViewCell"
    }
    
    private let viewModel = PackageSourceCellModel()
    private let sourceResponseModel = PackageSourceModel()
    
    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .white
            descriptionLabel.font = AppFont.description.getFont()
        }
    }
    
    @IBOutlet private var selectionButton: UIButton!
    
    private var isCellSelected: Bool = false

    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentView()
    }
    
    func configure(with model: PackageSourceModel) {
        descriptionLabel.text = model.name
        configureSelectionButton(with: isCellSelected)
    }
}

// MARK: - CellDidSelected
extension PackageSourceTableViewCell {
    func didSelected() {
        var isCellSelected = isCellSelected
        isCellSelected.toggle()
        
        self.isCellSelected = isCellSelected
        configureSelectionButton(with: isCellSelected)
        animateSelection()
    }
    
    private func isSourceSelected() {
        if viewModel.selectedSourcesIDs.contains(where: {$0 == sourceResponseModel.id}) {
            
        }
    }
}

// MARK: - Helpers
extension PackageSourceTableViewCell {
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
