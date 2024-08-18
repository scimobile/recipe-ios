//
//  UIButton.swift
//  Recipe
//
//  Created by kukuzan on 06/08/2024.
//

import UIKit

extension UIButton {
    func setTitleUnderLine(title: String) {
        let myNormalAttributedTitle = NSAttributedString(
            string: title,
            attributes: [
                NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
                
            ]
        )
        
        self.setAttributedTitle(myNormalAttributedTitle, for: .normal)
    }
    
    public func setButtonTitleStyle(_ font: UIFont, _ color: UIColor?) {
        self.titleLabel?.font = font
        self.setTitleColor(color, for: .normal)
    }
}
