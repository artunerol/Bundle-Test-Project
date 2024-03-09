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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            animateSelection()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10,
                                                                     left: 0,
                                                                     bottom: 10,
                                                                     right: 0))
    }
    
    func configure(with model: PackageModel) {
        setupContentView()
        descriptionLabel.text = model.description
        descriptionLabel.textColor = UIColor(hex: model.style.fontColor)
        
        // 3rd party libraries could be used instead of this solution. Such as: Kingfisher
        model.image.getImage { [weak self] image in
            DispatchQueue.main.async {
                self?.thumbnailImageView.image = image
            }
        }
    }
}

// MARK: - Helpers
extension PackageListTableViewCell {
    private func setupContentView() {
        //Setting shadow and cornerRadius for contentview because contentView offset was used for cell spacing
        backgroundColor = .clear
        
        contentView.backgroundColor = AppColor.primary.getColor()
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowColor = UIColor.white.cgColor
        
        contentView.layer.cornerRadius = 8
    }
    
    private func animateSelection() {
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: .curveLinear) {
            self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1.05)
        } completion: { [weak self] isCompleted in
            if isCompleted {
                UIView.animate(withDuration: 0.15) {
                    self?.contentView.transform = .identity
                }
            }
        }
    }
}
