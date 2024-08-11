//
//  KeychainManager.swift
//  Recipe
//
//  Created by user on 11/08/2024.
//

import Foundation
import KeychainAccess

class KeychainManager {
    
    private let keyChain: Keychain
    private let ACCESS_TOKEN_KEY = "ACCESS_TOKEN"
    
    static let shared: KeychainManager = .init()
    
    private init() {
        keyChain = Keychain(service: "com.sci.recipe-ios.keystore")
    }
    
    func saveAccessToken(with accesToken: String) {
        keyChain[ACCESS_TOKEN_KEY] = accesToken
    }
    
    func getAccessToken() -> String? {
        return keyChain[ACCESS_TOKEN_KEY]
    }
    
    func removeAccessToken() {
        keyChain[ACCESS_TOKEN_KEY] = nil
    }
    
}

