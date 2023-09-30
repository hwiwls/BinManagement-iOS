//
//  UIView+addSubViews.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/09/26.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
