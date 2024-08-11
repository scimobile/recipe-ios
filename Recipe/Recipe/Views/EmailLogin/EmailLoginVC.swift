//
//  EmailLoginVC.swift
//  Recipe
//
//  Created by user on 08/08/2024.
//

import UIKit

class EmailLoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    lazy var vm: LoginVM = LoginVM.init(delegate: self)
    
    // MARK: LifeCycle
    // Refactored Code
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        updateLoginButtonState()
    }
    
    // MARK: Selector
    
    @objc func onTapLogin() {
        vm.login()
    }
    
    @objc func textFieldDidChange() {
        updateLoginButtonState()
    }
    
    func updateLoginButtonState() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        loginButton.isEnabled = ValidationService.validateEmail(email) && ValidationService.validatePassword(password)
    }

    // MARK: Helpers
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension EmailLoginVC: LoginViewDelegate {
    
    func onValidate(validationError: [LoginVM.FormInput]) {
        if validationError.isEmpty {
            
        } else {
            
        }
    }
    
    func onError(error: String) {
        DispatchQueue.main.async {
            self.showAlert(message: error)
            print("DEBUG: \(error.localizedCapitalized)")
        }
    }
    
    func onLoginSuccess() {
        DispatchQueue.main.async {
            print("DEBUG: HomeScreen")
        }
    }
    
    func onNewuser() {
        DispatchQueue.main.async {
            print("DEBUG: RegisterScreen")
        }
    }
    
    
}
