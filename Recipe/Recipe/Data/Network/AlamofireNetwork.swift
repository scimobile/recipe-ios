//
//  AlamofireNetwork.swift
//  Recipe
//
//  Created by user on 09/08/2024.
//

import UIKit
import Alamofire

class AlamofireNetwork {
    static let shared: AlamofireNetwork = AlamofireNetwork.init()
    private let session: Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // Set timeout interval
        session = Session(configuration: configuration, interceptor: RecipeRequestInterceptor())
    }
    
    // MARK: Network Request Method 1
    
    func request(endpoint: AlamofireEndpoint,
                             completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        session
            .request(
                endpoint,
                method: endpoint.httpMethod,
                parameters: endpoint.paramter,
                encoding: endpoint.encoding,
                headers: endpoint.header
            )
            .validate { request, response, data in
                if response.statusCode == 401 {
                    return .failure(NetworkError.unexpectedStatusCode(response.statusCode))
                } else {
                    return .success(())
                }
            }
            .response { afResponse in
                if let statusCode = afResponse.response?.statusCode {
                    if (200..<300) ~= statusCode {
                        if let data = afResponse.data {
                            do {
                                let object = try JSONDecoder().decode(LoginResponse.self, from: data)
                                completion(.success(object))
                            } catch {
                                completion(.failure(.unknown))
                            }
                        } else {
                            completion(.failure(.emptyResponse))
                        }
                    } else {
                        completion(.failure(NetworkError.unexpectedStatusCode(statusCode)))
                    }
                } else {
                    completion(.failure(.emptyResponse))
                }
            }
    }
    
    // MARK: Network Request Method 2
    
    func request<T: Codable>(
        endpoint: AlamofireEndpoint,
        onSuccessHandler: @escaping (T) -> (),
        onFailedHandler: @escaping (NetworkError) -> ()
    ) {
        session
            .request(
                endpoint,
                method: endpoint.httpMethod,
                parameters: endpoint.paramter,
                encoding: endpoint.encoding,
                headers: endpoint.header
            )
            .validate({ request, response, data in
                if response.statusCode == 401 {
                    return .failure(NetworkError.unexpectedStatusCode(response.statusCode))
                } else if response.statusCode == 403 {
                    return .failure(NetworkError.invalidURL)
                } else {
                    return .success(())
                }
            })
            .response { afResponse in
                switch afResponse.result {
                    case .success:
                        if let data = afResponse.data {
                            do {
                                let object = try JSONDecoder().decode(T.self, from: data)
                                onSuccessHandler(object)
                            } catch {
                                print("Decoding Error: \(error)")
                                onFailedHandler(.decodeError)
                            }
                        } else {
                            onFailedHandler(.emptyResponse)
                        }
                    case .failure(let error):
                        print("Request Error: \(error)")
                        if let statusCode = afResponse.response?.statusCode {
                            onFailedHandler(NetworkError.unexpectedStatusCode(statusCode))
                        } else {
                            onFailedHandler(.emptyResponse)
                        }
                }
            }
    }
}

