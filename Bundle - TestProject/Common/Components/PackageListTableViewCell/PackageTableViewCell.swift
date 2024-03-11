//
//  PackageListTableViewCell.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import UIKit

enum PackageType {
    case packageList
    case packageSource
}

class PackageTableViewCell: UITableViewCell {
    var model: PackageModel? = nil
    static let height: CGFloat = 120
    static let identifer: String = "PackageListTableViewCell"

    
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .white
            descriptionLabel.font = AppFont.description.getFont()
        }
    }
    
    @IBOutlet private var selectionButton: UIButton!
    
    private var isAdded: Bool = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            isAdded = true
            toggleButtonSelection()
            animateSelection()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    func configure(with model: PackageModel, type: PackageType) {
        self.model = model
        
        switch type {
        case .packageList:
            thumbnailImageView.isHidden = false
            descriptionLabel.text = model.description
            descriptionLabel.textColor = UIColor(hex: model.style?.fontColor ?? "") //Getting fontColor from API
            isAdded = model.isAdded
            
            thumbnailImageView.loadImageWith(urlString: model.image ?? "")
            toggleButtonSelection()
            
        case .packageSource:
            thumbnailImageView.isHidden = true
            descriptionLabel.text = model.name
            isAdded = model.isAdded
            toggleButtonSelection()
        }
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
    
    private func toggleButtonSelection() {
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
