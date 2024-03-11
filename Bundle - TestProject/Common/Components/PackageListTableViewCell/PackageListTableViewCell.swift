//
//  PackageListTableViewCell.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import UIKit

class PackageListTableViewCell: UITableViewCell {
    static let height: CGFloat = 120
    static let identifer: String = "PackageListTableViewCell"
    
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = AppFont.description.getFont()
        }
    }
    
    @IBOutlet private var selectionButton: UIButton!
    
    private var isAdded: Bool = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        toggleSelection()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    func configure(with model: PackageModel) {
        descriptionLabel.text = model.description
        descriptionLabel.textColor = UIColor(hex: model.style.fontColor) //Getting fontColor from API
        isAdded = model.isAdded
        
        // 3rd party libraries could be used instead of this solution. Such as: Kingfisher
        thumbnailImageView.loadImageWith(urlString: model.image)
        toggleSelection()
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
    
    private func toggleSelection() {
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
