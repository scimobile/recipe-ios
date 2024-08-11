//
//  LoginSelectVC.swift
//  Recipe
//
//  Created by user on 08/08/2024.
//

import UIKit

class LoginSelectVC: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var btnEmail: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkUserLoginStatus()

        btnEmail.addTarget(self, action: #selector(navigateToEmailScreen), for: .touchUpInside)
    }
    
    @objc func navigateToEmailScreen() {
        print("Email Screen")
        
        let emailLoginVC = EmailLoginVC()
//        emailLoginVC.modalPresentationStyle = .fullScreen
//        self.present(emailLoginVC, animated: true)
        
        navigationController?.pushViewController(emailLoginVC, animated: true)
        
    }
    
    private func checkUserLoginStatus() {
        if KeychainManager.shared.getAccessToken() != nil {
            print("DEBUG: HomeScreen")
        }
    }

}
