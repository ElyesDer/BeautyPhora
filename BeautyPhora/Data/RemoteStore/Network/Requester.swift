//
//  Requester.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

class Requester: DataServiceProviderProtocol {
    
    enum ServiceError: Error {
        case urlRequest
        case statusCodeError(Int)
        case responseError
        case decodingError
    }
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request<T>(from provider: NetworkProviderProtcol, of type: T.Type) async throws -> T where T: Decodable {
        
        guard let urlRequest: URLRequest = try? provider.buildURLRequest() else {
            throw ServiceError.urlRequest
        }
        
        let sessionResponse = try await urlSession.data(for: urlRequest)
        
        // handle errors
        guard let response = sessionResponse.1 as? HTTPURLResponse else {
            throw ServiceError.responseError
        }
        
        guard response.statusCode == 200 else {
            throw ServiceError.statusCodeError(response.statusCode)
        }
        
        guard let resultObject = try? JSONDecoder().decode(T.self, from: sessionResponse.0) else {
            throw ServiceError.decodingError
        }
        return resultObject
    }
}
