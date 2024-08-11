//
//  LoginRequest.swift
//  Recipe
//
//  Created by user on 10/08/2024.
//

import Foundation

struct LoginRequest: Codable {
    let email:String
    let password:String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password
        
    }
}
