//
//  ValidationService.swift
//  Recipe
//
//  Created by user on 09/08/2024.
//

import Foundation

protocol ValidationService {
    func validate(_ input: String) -> Bool
}

class EmailValidationService: ValidationService {
    func validate(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

class PasswordValidationService: ValidationService {
    func validate(_ password: String) -> Bool {
        return password.count >= 8 && !password.isEmpty
    }
}

