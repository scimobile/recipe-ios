//
//  AuthRemoteDatasource.swift
//  Recipe
//
//  Created by user on 10/08/2024.
//

import Foundation

enum AuthDataError: Error {
    case NEW_USER
    case USER_ALREADY_REGISTERED
    case UNKNOWN(String)
}

class AuthRemoteDatasource {
    
    private let network: AlamofireNetwork = AlamofireNetwork.shared
    private let newUserErrorCode: Int = 404
    private let duplicateUserErrorCode: Int = 409
    
    func login(
        email: String,
        password: String,
        onSuccess: @escaping (String) -> (),
        onFail: @escaping (AuthDataError) -> ()
    ) {
        let endpoint = AlamofireRecipeEndpoint.Login(LoginRequest(email: email, password: password))
        
        network.request(
            endpoint: endpoint,
            onSuccessHandler: { (response: LoginResponse) in
                if let accessToken = response.data?.accessToken, !accessToken.isEmpty {
                    onSuccess(accessToken)
                } else {
                    onFail(.UNKNOWN("Access token is missing or empty"))
                }
            },
            onFailedHandler: { error in
                switch error {
                case .unexpectedStatusCode(let code):
                    if code == self.newUserErrorCode {
                        onFail(.NEW_USER)
                    } else if code == self.duplicateUserErrorCode {
                        onFail(.USER_ALREADY_REGISTERED)
                    } else {
                        onFail(.UNKNOWN("Unexpected status code: \(code)"))
                    }
                case .emptyResponse:
                    onFail(.UNKNOWN("The response was empty"))
                default:
                    onFail(.UNKNOWN("An unknown error occurred"))
                }
            }
        )
        
    }
    
    // MARK:
    
    func signUp(
        userName: String,
        email: String,
        phone: String,
        password: String,
        onSuccess: @escaping (String) -> (),
        onFail: @escaping (AuthDataError) -> ()
    ) {
        let registerRequest = RegisterRequest(userName: userName, email: email, phone: phone, password: password)
        let endpoint = AlamofireRecipeEndpoint.Register(registerRequest)
        
        network.request(
            endpoint: endpoint,
            onSuccessHandler: { (response: RegisterResponse) in
                if response.code == 201, let accessToken = response.data?.accessToken, !accessToken.isEmpty {
                    onSuccess(accessToken)
                } else {
                    onFail(.UNKNOWN("Something went wrong!"))
                }
            },
            onFailedHandler: { error in
                switch error {
                case .unexpectedStatusCode(let code):
                    if code == self.duplicateUserErrorCode {
                        onFail(.USER_ALREADY_REGISTERED)
                    } else {
                        onFail(.UNKNOWN("Unexpected status code: \(code)"))
                    }
                case .emptyResponse:
                    onFail(.UNKNOWN("The response was empty"))
                default:
                    onFail(.UNKNOWN("An unknown error occurred"))
                }
            }
        )
    }
    
}

