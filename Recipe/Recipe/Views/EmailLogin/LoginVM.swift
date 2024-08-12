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
  

        if let email = email, let password = password, !email.isEmpty, !password.isEmpty, ValidationService.validatePassword(password), ValidationService.validateEmail(email){
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
        
//        if !ValidationService.validateEmail(email!) {
//            errors.append(
//                FormInput.UserNameTextField("* Username cannot be empty")
//            )
//        }
//        
//        if !ValidationService.validatePassword(password!) {
//            errors.append(
//                FormInput.PasswordTextField("* Password cannot be empty")
//            )
//        }
        
        delegate.onValidate(validationError: errors)
    }
}
