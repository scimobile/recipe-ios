//
//  SignupVC.swift
//  Recipe
//
//  Created by Khine Khine Myat Noe on 09/08/2024.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var tfDisplayName: FloatingLabelInput!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var ImgCheck: UIImageView!
    @IBOutlet weak var tfEmail: FloatingLabelInput!
    
    @IBOutlet weak var tfPassword: FloatingLabelInput!
    @IBOutlet weak var tfConfirmPassword: FloatingLabelInput!
    
    @IBOutlet weak var lblDisplayNameError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    
    @IBOutlet weak var btnTnC: UIButton!
    
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var btnConfirmPassword: UIButton!
    private var acceptedTnC: Bool = false {
        didSet {
            ImgCheck.image =  UIImage(named: acceptedTnC ? "ic.check" : "ic.uncheck")
        }
    }
    
    private var isPasswordSecure: Bool = false {
        didSet {
            tfPassword.isSecureTextEntry = isPasswordSecure
        }
    }
    
    private var isConfirmSecure: Bool = false {
        didSet {
            tfConfirmPassword.isSecureTextEntry = isConfirmSecure
        }
    }

    
    lazy var vm: SignupVM = .init(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        // Do any additional setup after loading the view.
    }

    private func setupUI() {
        btnNext.isEnabled = false
        btnNext.backgroundColor = .disabledBtn
        btnNext.setButtonTitleStyle(.popSemiB14, .pureWhite)
        self.navigationItem.setHidesBackButton(true, animated: true)

    }
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    private func setupBinding() {
        
        tfDisplayName.addTarget(self, action: #selector(onChangeDisplayName), for: .editingChanged)
        tfEmail.addTarget(self, action: #selector(onChangeEmailName), for: .editingChanged)
        tfPassword.addTarget(self, action:#selector(onChangePassword), for: .editingChanged)
        tfConfirmPassword.addTarget(self, action:#selector(onChangeConfirmPassword), for: .editingChanged)
        
        btnTnC.addTarget(self, action: #selector(onChangeTnC), for: .touchUpInside)
        
        btnConfirmPassword.addTarget(self, action: #selector(onClickConfirmPassword), for: .touchUpInside)
        btnPassword.addTarget(self, action: #selector(onClickPassword), for: .touchUpInside)
    }
    
    @objc func onClickConfirmPassword() {
        isConfirmSecure = !isConfirmSecure
    }
    
    @objc func onClickPassword() {
        isPasswordSecure = !isPasswordSecure
    }
    

    
    @objc func onChangeTnC() {
        acceptedTnC = !acceptedTnC
    }
    
    
    @objc func onChangeDisplayName() {
        vm.setDisplayName(displayName: tfDisplayName.text)
        
    }
    
    @objc func onChangeEmailName() {
        vm.setEmail(email: tfEmail.text)
    }
    
    @objc func onChangePassword() {
        vm.setPassword(password: tfPassword.text)
    }
    
    @objc func onChangeConfirmPassword() {
        vm.setConfirmPassword(confirmPassword: tfConfirmPassword.text)
    }
    
    private func setErrorMesage(with Label: UILabel, and message: String) {
        Label.text = message
        Label.isHidden = false
    }
    
    private func resetErrors() {
        lblDisplayNameError.isHidden = true
        lblEmailError.isHidden = true
        lblPassword.isHidden = true
        lblConfirmPassword.isHidden = true
    }

    
}
extension SignupVC: SignupViewDelegate {
    func onValidate(validationError: [SignupVM.FormInput]) {
       print(validationError.count)
        if validationError.isEmpty {
            btnNext.isEnabled = true
            btnNext.backgroundColor = .activeOrange
            resetErrors()
        } else {
            
            validationError.forEach { inputType in
                switch inputType {
                case .DisplayNameTextField(let error):
                        setErrorMesage(with: lblDisplayNameError, and: error)
                    break;
                case .EmailTextField(let error):
                        setErrorMesage(with: lblEmailError, and: error)
                    break;
                case .PasswordTextField(let error):
                        setErrorMesage(with: lblPassword, and: error)
                    break;
                case .ConfirmPasswordTextField(let error):
                        setErrorMesage(with: lblConfirmPassword, and: error)
                    break;
                }
            }
        }
    }
    
    func onError(error: String) {
    
    }
    
    func onLoginSuccess() {
    
    }
    
    
}
