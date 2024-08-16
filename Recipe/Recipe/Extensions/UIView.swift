//
//  UIView.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func borderStyle(width: CGFloat, borderColor: UIColor) {
        layer.borderWidth = width
        layer.borderColor = borderColor.cgColor
    }
}
