//
//  UIColor+CustomColor.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/09/26.
//

import UIKit

extension UIColor {
    static let customColor = CustomColors()
    
    struct CustomColors {
        let customSuperLightGray = UIColor(named: "CustomSuperLightGray") ?? .white
        let customRegularLightGray = UIColor(named: "CustomRegularLightGray") ?? .white
    }
}

