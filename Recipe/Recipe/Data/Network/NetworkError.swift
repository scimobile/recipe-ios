//
//  NetworkError.swift
//  Recipe
//
//  Created by user on 09/08/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unknown
    case decodeError
    case emptyResponse
    case unexpectedStatusCode(Int)
    
    var customMessage: String {
        switch self {
            case .invalidURL:
                return "Invalid URL"
            case .unknown:
                return "Something went wrong"
            case .decodeError:
                return "Decode error"
            case .emptyResponse:
                return "Empty Response"
            case .unexpectedStatusCode(let code):
                return "Unexpected Status Code: \(code)"
        }
    }
}
