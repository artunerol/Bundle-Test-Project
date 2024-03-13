//
//  UIview+NibName.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import UIKit

extension UIView {
    static func getNibName() -> String {
        String(describing: self)
    }
}

