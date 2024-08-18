//
//  LoginResponse.swift
//  Recipe
//
//  Created by user on 10/08/2024.
//

import Foundation

struct LoginResponse: Codable {
    let code: Int
    let message: String?
    let data: LoginVO?
}

struct LoginVO: Codable {
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey  {
        case accessToken = "access_token"
    }
}

typealias RegisterResponse = LoginResponse
