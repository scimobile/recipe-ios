//
//  RegisterRequest.swift
//  Recipe
//
//  Created by user on 10/08/2024.
//

import Foundation

struct RegisterRequest: Codable {
    let userName:String
    let email:String
    let phone:String
    let password:String
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case password,email
        case phone = "phone_number"
        
    }
}
