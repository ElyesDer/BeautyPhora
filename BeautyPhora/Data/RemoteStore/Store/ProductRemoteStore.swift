//
//  ProductRemoteStore.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

class ProductRemoteStore: ProductRemoteStoreProtocol, HasDataServiceProviderProtocol {
    
    var requester: DataServiceProviderProtocol
    
    init(requester: DataServiceProviderProtocol) {
        self.requester = requester
    }
    
    func getProducts() async throws -> PProducts {
        // init endpoint
        let endpoint = Endpoint(method: .get, endURL: APIProvider.items)
        return try await requester.request(from: endpoint, of: Products.self)
    }
    
    func getProducts() -> Observable<PProducts> {
        // init endpoint
        let endpoint = Endpoint(method: .get, endURL: APIProvider.items)
        let observedProducts = requester.requestRx(from: endpoint, of: Products.self)
        return observedProducts.map { $0 as PProducts }
    }
}
