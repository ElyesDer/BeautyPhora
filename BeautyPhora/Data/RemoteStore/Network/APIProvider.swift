//
//  APIProvider.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

enum NetworkProviderError: Error {
    case urlBuilder
    case urlRequest
}

public enum APIProvider: APIProviderProtocol {
    
    public var baseUrl: String {
        "https://sephoraios.github.io/"
    }
    
    case items
    
    public var rawValue: String {
        switch self {
            case .items:
                return baseUrl + "items.json"
        }
    }
}
