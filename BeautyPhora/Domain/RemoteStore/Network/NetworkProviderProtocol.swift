//
//  NetworkProvider.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

public protocol APIProviderProtocol {
    var baseUrl: String { get }
    var rawValue: String { get }
}

public enum HTTPMethods: String {
    case get = "GET"
}

public protocol NetworkProviderProtcol {
    var method: HTTPMethods { get }
    var endURL: APIProviderProtocol { get }
    func buildURLRequest() throws -> URLRequest
}
