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
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnPasswordIcon: UIButton!
    
    var passwordShowHide: Bool = false {
        didSet {
            passwordTextField.isSecureTextEntry = passwordShowHide
        }
    }
    
    lazy var vm: LoginVM = LoginVM.init(delegate: self)
    
    // MARK: LifeCycle
    // Refactored Code
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Selector
    func setupUI() {
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        updateLoginButtonState()
        btnBack.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
        btnClear.addTarget(self, action: #selector(onTapClearButton), for: .touchUpInside)
        loginButton.isEnabled = false
        loginButton.backgroundColor = .disabledBtn
        loginButton.setTitleColor(.pureWhite, for: .normal)
        btnPasswordIcon.addTarget(self, action: #selector(onTapPasswordIcon), for: .touchUpInside)
        btnClear.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func onTapClearButton() {
        
        passwordTextField.text = ""
        vm.setPassword(password: "")
        btnClear.isHidden = true
    }
    
    @objc func onTapPasswordIcon() {
        passwordShowHide = !passwordShowHide
    }
    
    @objc func onTapLogin() {
        vm.login()
    }
    
    @objc func onTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange() {
        updateLoginButtonState()
    }
    
    func updateLoginButtonState() {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if let password = password, !password.isEmpty {
            btnClear.isHidden = false
        }
        
        vm.setEmail(email: email)
        vm.setPassword(password: password)
        
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
            loginButton.isEnabled = true
            loginButton.backgroundColor = .activeOrange
            loginButton.setTitleColor(.pureWhite, for: .normal)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .disabledBtn
            
        }
    }
    
    func onError(error: String) {
        DispatchQueue.main.async {
            self.showAlert(message: error)
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
