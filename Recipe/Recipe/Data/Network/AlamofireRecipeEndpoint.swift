//
//  AlamofireRecipeEndpoint.swift
//  Recipe
//
//  Created by user on 09/08/2024.
//

import Foundation
import Alamofire

enum AlamofireRecipeEndpoint: AlamofireEndpoint {
    
    case Login(Encodable)
    case Register(Encodable)
    
    var path: String {
        switch self {
            case .Login:
                return "/auth/login"
            case .Register:
                return "/auth/register"

        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
            case .Login, .Register:
                return .post
        }
    }
    
    var paramter: Alamofire.Parameters? {
        switch self {
            case .Login(let request), .Register(let request):
                return request.toDict()
        }
    }
    
    var encoding: any Alamofire.ParameterEncoding {
        switch self {
            case .Login,.Register:
                return JSONEncoding.default
        }
    }
    
    var header: Alamofire.HTTPHeaders? {
        switch self {
            case .Login, .Register:
                return nil
        }
    }
}

extension Encodable {
    func toDict() -> [String:Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dic ?? [:]
        } catch {
            return [:]
        }
    }
}
