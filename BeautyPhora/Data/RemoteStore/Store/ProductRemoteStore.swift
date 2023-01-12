//
//  ProductRemoteStore.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

class ProductRemoteStore: ProductRemoteStoreProtocol, HasDataServiceProviderProtocol {
    
    var requester: DataServiceProviderProtocol
    
    init(requester: DataServiceProviderProtocol) {
        self.requester = requester
    }
    
    func getProducts() async throws -> Products {
        // init endpoint
        let endpoint = Endpoint(method: .get, endURL: APIProvider.items)
        return try await requester.request(from: endpoint, of: Products.self)
    }
}
