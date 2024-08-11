//
//  SignupOptionsVC.swift
//  Recipe
//
//  Created by Khine Khine Myat Noe on 10/08/2024.
//

import UIKit
import FacebookLogin
import GoogleSignIn

class SignupOptionsVC: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnEmail: UIButton!
    
    @IBOutlet weak var btnGoogleLogin: UIButton!
    
    
    @IBOutlet weak var btnFacebookLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = AccessToken.current,
              !token.isExpired {
            print("token expired \(token)")
              // User is logged in, do work such as go to next view controller.
          }
        setupUI()
        
    }
    
    private func setupUI() {
        btnLogin.setTitleUnderLine(title: "Log In")
        btnLogin.setTitleColor(.pureWhite, for: .normal)
        btnGoogleLogin.addTarget(self, action: #selector(onClickGoogleLogin), for: .touchUpInside)
        btnFacebookLogin.addTarget(self, action: #selector(onClickFacebooLogin), for: .touchUpInside)
    }
    
    @objc func onClickGoogleLogin() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
           guard error == nil else { return }

           // If sign in succeeded, display the app's main content View.
           
            guard let signInResult = signInResult else { return }

                let user = signInResult.user
            
            

                let emailAddress = user.profile?.email
            
                let fullName = user.profile?.name
                let givenName = user.profile?.givenName
                let familyName = user.profile?.familyName
            
            print("loginGoogle \(String(describing: user.accessToken))")

                let profilePicUrl = user.profile?.imageURL(withDimension: 320)
         }
        
    }
    
    @objc func onClickFacebooLogin() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"], from: self) { result, error in
            if let error = error {
                // Handle error
                print("Error occurred during login: \(error.localizedDescription)")
                return
            }
            
            guard let result = result else {
                // Handle the case where result is nil
                print("Login result is nil")
                return
            }
            
          
            if result.isCancelled {
                // Handle case where user cancelled the login
                print("Login cancelled by user")
            } else if result.grantedPermissions.contains("email") {
                // The user granted the email permission
                // Use the token to fetch user info
                if let tokenString = AccessToken.current?.tokenString {
                    print("tokenString \(tokenString)")
                    let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
                    request.start { _, result, error in
                        if let error = error {
                            // Handle error
                            print("Error fetching user info: \(error.localizedDescription)")
                        } else if let result = result as? [String: Any] {
                            // Access user information
                            let id = result["id"] as? String
                            let name = result["name"] as? String
                            let email = result["email"] as? String
                            print("User ID: \(id ?? "N/A")")
                            print("User Name: \(name ?? "N/A")")
                            print("User Email: \(email ?? "N/A")")
                        }
                    }
                }
            } else {
                // Handle the case where the user didn't grant the email permission
                print("Email permission not granted")
            }
        }
    }

    @IBAction func onClickSignup(_ sender: UIButton) {
        
        let SignupVC = SignupVC()
        navigationController?.pushViewController(SignupVC, animated: true)
        
    }
    
}
