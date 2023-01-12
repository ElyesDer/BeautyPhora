//
//  Endpoint.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

public struct Endpoint: NetworkProviderProtcol {
    
    public var method: HTTPMethods
    public let endURL: APIProviderProtocol
    
    public init(method: HTTPMethods,
                endURL: APIProviderProtocol) {
        self.method = method
        self.endURL = endURL
    }
    
    public func buildURLRequest() throws -> URLRequest {
        guard let formatedUrl = self.endURL.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: formatedUrl) else { throw NetworkProviderError.urlBuilder }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
