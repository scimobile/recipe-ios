//
//  AuthRepository.swift
//  Recipe
//
//  Created by user on 10/08/2024.
//

import Foundation

class AuthRepository {
    
    private let authRemoteDatasource: AuthRemoteDatasource = .init()
    
    func login(
        email: String,
        password: String,
        onSuccess: @escaping () -> (),
        onFail: @escaping (AuthDataError) -> ()
    ) {
        authRemoteDatasource
            .login(
                email: email,
                password: password,
                onSuccess: { accessToken in
                    KeychainManager.shared.saveAccessToken(with: accessToken)
                    onSuccess()
                },
                onFail: onFail)
    }
    
    func signup(
        username: String,
        email: String,
        phone: String,
        password: String,
        onSuccess: @escaping () -> (),
        onFail: @escaping (AuthDataError) -> ()
    ) {
        authRemoteDatasource
            .signUp(userName: username,
                    email: email,
                    phone: phone,
                    password: password,
                    onSuccess: { accessToken in
                KeychainManager.shared.saveAccessToken(with: accessToken)
                onSuccess()
            }, onFail: onFail)
    }
}
