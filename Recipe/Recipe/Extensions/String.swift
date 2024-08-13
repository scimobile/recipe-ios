//
//  String.swift
//  Recipe
//
//  Created by Khine Khine Myat Noe on 10/08/2024.
//

import Foundation
import RegexBuilder

extension Optional where Wrapped == String {
    var isValidEmail: Bool {
       
        guard let email = self, !email.isEmpty, email.wholeMatch(of: emailRegex) != nil else { return false }
        return true
        
    }
}


extension Optional where Wrapped == String {
    var isValidPassword: Bool {
        guard let password = self, !password.isEmpty, password.wholeMatch(of: passwordCheckRegex) != nil else { return false }
        return true
    }
}

