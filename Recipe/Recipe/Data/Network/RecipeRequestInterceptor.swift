//
//  RecipeRequestInterceptor.swift
//  Recipe
//
//  Created by user on 10/08/2024.
//

import Foundation
import Alamofire

class RecipeRequestInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        let url = request.url?.path(percentEncoded: false)
            .replacingOccurrences(of: "/api", with: "")
        
        switch url {
            case AlamofireRecipeEndpoint.Login(0).path,
                AlamofireRecipeEndpoint.Register(0).path:
                break
            default:
                if let token = KeychainManager.shared.getAccessToken(), !token.isEmpty {
                    request.headers.add(
                        .authorization(bearerToken: token)
                    )
                }
                break
        }
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        if request.response?.statusCode == 401 {
            print("Token Expired")
            //Send out global event
            NotificationCenter.default.post(name: .TokenExpiredNotification, object: nil)
        }
        completion(.doNotRetry)
    }
}

extension NSNotification.Name {
    static var TokenExpiredNotification = NSNotification.Name("token_expired")
}
