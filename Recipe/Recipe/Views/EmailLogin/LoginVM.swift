//
//  LoginVM.swift
//  Recipe
//
//  Created by user on 10/08/2024.
//

import Foundation

protocol LoginViewDelegate {
    func onValidate(validationError: [LoginVM.FormInput])
    func onError(error: String)
    func onLoginSuccess()
    func onNewuser()
}

class LoginVM {
    
    enum FormInput {
        case UserNameTextField(String)
        case PasswordTextField(String)
    }
    
    private let repository: AuthRepository = .init()
    private let delegate: LoginViewDelegate
    
    private var email: String? = nil {
        didSet {
            validate()
        }
    }
    private var password: String? = nil {
        didSet {
            validate()
        }
    }
    
    init(delegate: LoginViewDelegate) {
        self.delegate = delegate
    }
    
    func setEmail(email: String?) {
        self.email = email
    }
    
    func setPassword(password: String?) {
        self.password = password
    }
    
    func login() {
        if let email = email, let password = password, !email.isEmpty, !password.isEmpty {
            repository.login(
                email: email,
                password: password,
                onSuccess: { [weak self] in
                    self?.delegate.onLoginSuccess()
                },
                onFail: { [weak self] error in
                    switch error {
                    case .NEW_USER:
                        self?.delegate.onNewuser()
                    case .UNKNOWN(let error):
                        self?.delegate.onError(error: error)
                    default:
                        break
                    }
                })
        }
    }
    
    private func validate() {
        var errors: [LoginVM.FormInput ] = []
        
        if email.isValidEmail == false {
            errors.append(FormInput.UserNameTextField("*Email is not valid"))
        }
        if !password.isValidPassword {
            errors.append(FormInput.PasswordTextField("*Password is not valid"))
        }
        delegate.onValidate(validationError: errors)
    }
}
