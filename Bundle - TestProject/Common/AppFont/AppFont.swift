//
//  AppFont.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 8.03.2024.
//

import UIKit

enum AppFont {
    case header
    case description
    
    func getFont() -> UIFont {
        switch self {
        case .header:
            UIFont.systemFont(ofSize: 24, weight: .bold)
        case .description:
            UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
    }
}
