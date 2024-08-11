//
//  AlamofireEndpoint.swift
//  Recipe
//
//  Created by user on 09/08/2024.
//

import Foundation
import Alamofire

protocol AlamofireEndpoint: URLConvertible {
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod:Alamofire.HTTPMethod {get}
    var paramter:Parameters? {get}
    var encoding: ParameterEncoding {get}
    var header: HTTPHeaders? {get}
}

extension AlamofireEndpoint {
    
    var baseURL: URL {
        URL(string: Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "")!
    }
    
    func asURL() throws -> URL {
        return baseURL.appending(path: path)
    }
    
}
