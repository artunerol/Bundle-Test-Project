//
//  PackageSourceTableViewCell.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 12.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class PackageSourceTableViewCell: UITableViewCell {
    struct Constants {
        static let height: CGFloat = 120
        static let identifer: String = "PackageSourceTableViewCell"
    }
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .white
            descriptionLabel.font = AppFont.description.getFont()
        }
    }
    
    @IBOutlet private var selectionButton: UIButton!
    
    private let isSelectedRelay: BehaviorRelay<Bool> = .init(value: false)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindSelected()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentView()
    }
    
    func configure(with model: PackageSourceModel) {
        descriptionLabel.text = model.name
    }
}

// MARK: - CellDidSelected
extension PackageSourceTableViewCell {
    func didSelected() {
        toggleSelection()
        animateSelection()
    }
}

// MARK: - Helpers
extension PackageSourceTableViewCell {
    func configureSelectionUI() {
        isSelectedRelay.accept(true)
    }
    
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
        var isCellSelectedToggled = isSelectedRelay.value
        isCellSelectedToggled.toggle()
        isSelectedRelay.accept(isCellSelectedToggled)
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

// MARK: - Rxbindings
extension PackageSourceTableViewCell {
    private func bindSelected() {
        isSelectedRelay
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] isCellSelected in
                guard let self = self else { return }
                
                if isCellSelected {
                    selectionButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                } else {
                    selectionButton.setImage(UIImage(systemName: "square"), for: .normal)
                }
            }
            .disposed(by: disposeBag)
    }
}
