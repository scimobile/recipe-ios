//
//  CustomPasswordTextField.swift
//  Recipe
//
//  Created by user on 08/08/2024.
//

import UIKit

class CustomPasswordTextField: UITextField {
    
    private let showHideButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShowHideButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShowHideButton()
    }
    
    private func setupShowHideButton() {
        showHideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        showHideButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        rightView = showHideButton
        rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "eye.slash" : "eye"
        showHideButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
