//
//  CustomTextField.swift
//  Recipe
//
//  Created by user on 08/08/2024.
//

import UIKit

class MaterialTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextField()
    }
    
    func setupTextField() {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
}

