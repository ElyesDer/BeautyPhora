//
//  DataServiceProvider.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

protocol HasDataServiceProviderProtocol {
    var requester: DataServiceProviderProtocol { get }
}

protocol DataServiceProviderProtocol {
    var urlSession: URLSession { get }
    func request<T>(from provider: NetworkProviderProtcol, of type: T.Type) async throws -> T where T: Decodable
}
