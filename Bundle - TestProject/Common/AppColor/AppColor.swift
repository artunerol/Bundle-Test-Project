//
//  AppColor.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import UIKit

enum AppColor {
    case background
    case primary
    case navBar
    
    func getColor() -> UIColor {
        switch self {
        case .background:
            UIColor(red: 0.07, green: 0.086, blue: 0.1, alpha: 1)
        case .primary:
            UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1)
        case .navBar:
            UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1)
        }
    }
}
