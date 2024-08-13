//
//  LoginSelectVC.swift
//  Recipe
//
//  Created by user on 08/08/2024.
//

import UIKit
import FacebookLogin
import GoogleSignIn

class LoginSelectVC: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var btnEmail: UIButton!
    
    @IBOutlet weak var btnGoogleLogin: UIButton!
    @IBOutlet weak var btnCreateAccount: UIButton!
    
    @IBOutlet weak var lblTC: UILabel!
    @IBOutlet weak var btnFacebookLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkUserLoginStatus()

        setUnderLine()
      
    }
    
    func setUnderLine() {
        // The full text for the label
        let fullText = "By using SideChef, you agree to our Privacy Notice and Terms of Use"

        // The word or phrase you want to underline
        let wordToUnderline = "Privacy Notice"
        let wordToUnderline2 = "Terms of Use"

        // Create an attributed string
        let attributedString = NSMutableAttributedString(string: fullText)

        // Find the range of the word or phrase you want to underline
        if let range = fullText.range(of: wordToUnderline) {
            let nsRange = NSRange(range, in: fullText)
            
            // Apply the underline attribute to the desired range
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
        }
        
        if let range = fullText.range(of: wordToUnderline2) {
            let nsRange = NSRange(range, in: fullText)
            
            // Apply the underline attribute to the desired range
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
        }


        // Set the attributed text to the label
        lblTC.attributedText = attributedString
    }
    
    func setupUI() {
        
        
        btnEmail.addTarget(self, action: #selector(navigateToEmailScreen), for: .touchUpInside)
        btnCreateAccount.addTarget(self, action: #selector(navigateToRegisterScreen), for: .touchUpInside)
        
        btnGoogleLogin.addTarget(self, action: #selector(onClickGoogleLogin), for: .touchUpInside)
        btnCreateAccount.setTitle("Already have an account?", for: .normal)
        btnCreateAccount.setTitleUnderLine(title: "Log In")
        btnFacebookLogin.addTarget(self, action: #selector(onClickFacebooLogin), for: .touchUpInside)
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
            
            print("loginGoogle \(String(describing: user.accessToken.tokenString))")

                let profilePicUrl = user.profile?.imageURL(withDimension: 320)
         }
        
    }
    
    @objc func navigateToEmailScreen() {
        print("Email Screen")
        
        let emailLoginVC = EmailLoginVC()
//        emailLoginVC.modalPresentationStyle = .fullScreen
//        self.present(emailLoginVC, animated: true)
        
        navigationController?.pushViewController(emailLoginVC, animated: true)
        
    }
    
    @objc func navigateToRegisterScreen() {
        print("Email Screen")
        
        let signupVC = SignupVC()
        
        navigationController?.pushViewController(signupVC, animated: true)
        
    }
    
    
    private func checkUserLoginStatus() {
        if KeychainManager.shared.getAccessToken() != nil {
            print("DEBUG: HomeScreen")
        }
    }

}
