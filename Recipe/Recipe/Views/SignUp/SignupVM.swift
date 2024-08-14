//
//  SignupVM.swift
//  Recipe
//
//  Created by Khine Khine Myat Noe on 10/08/2024.
//

import Foundation

protocol SignupViewDelegate {
    func onValidate(validationError: [SignupVM.FormInput])
    
    func onError(error: String)
    
    func onRegisterSuccess()
    
    func onUserAlreadyExist()
    
}

class SignupVM {
    
    enum FormInput {
        case DisplayNameTextField(String)
        case EmailTextField(String)
        case PasswordTextField(String)
        case ConfirmPasswordTextField(String)
    }
    
    private let delegate: SignupViewDelegate
    
    
    init(delegate: SignupViewDelegate) {
        self.delegate = delegate
    }
    
    private var displayName: String? = nil {
        didSet {
            validate()
        }
    }
    
    func setDisplayName(displayName: String?) {
        self.displayName = displayName
    }
    
    private var email: String? = nil {
        didSet {
            validate()
        }
    }
    private let repository: AuthRepository = .init()
    
    func setEmail(email: String?) {
        self.email = email
    }
    
    private var password: String? = nil {
        didSet {
            validate()
        }
    }
    
    func setPassword(password: String?) {
        self.password = password
    }
    
    private var confirmPassword: String? = nil {
        didSet {
            validate()
        }
    }
    
    func setConfirmPassword(confirmPassword: String?) {
        self.confirmPassword = confirmPassword
    }
    
    func register() {
        
        if let displayName = displayName,
           let email = email,
           let password = password,
           !displayName.isEmpty,
           !email.isEmpty,
           !password.isEmpty
        {
            repository
                .signup(username: displayName,
                        email: email,
                        phone: "",
                        password: password) { [weak self] in
                    self?.delegate.onRegisterSuccess()
                } onFail: { [weak self] error in
                    switch error {
                    case .USER_ALREADY_REGISTERED:
                        self?.delegate.onUserAlreadyExist()
                    case .UNKNOWN(let error):
                        self?.delegate.onError(error: error)
                    default:
                        break
                    }
                }
        }
    }
    
    
    
    private func validate() {
        
        var errors: [SignupVM.FormInput] = []
        if displayName == nil || displayName == "" {
            errors.append(FormInput.DisplayNameTextField("*Display name cannot be empty"))
        }
        if email.isValidEmail == false {
            errors.append(FormInput.EmailTextField("*Email is not valid"))
        }
        if password.isValidPassword == false {
            errors.append(FormInput.PasswordTextField("*Password is not valid"))
        }
        if confirmPassword == nil || confirmPassword == "" {
            errors.append(FormInput.ConfirmPasswordTextField("*Confirm Password cannot be empty"))
        }
        if password != confirmPassword  {
            errors.append(FormInput.PasswordTextField("*Password does not match"))
        }
        delegate.onValidate(validationError: errors)
    }
}
