//
//  ProductRemoteStore.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

class ProductRemoteStore: ProductRemoteStoreProtocol, DataServiceRequesterProviderProtocol {
    
    var requester: DataServiceProviderProtocol
    
    init(requester: DataServiceProviderProtocol) {
        self.requester = requester
    }
    
    func getProducts() -> Observable<ProductsProtocol> {
        // init endpoint
        let endpoint = Endpoint(method: .get, endURL: APIProvider.items)
        let observedProducts = requester.request(from: endpoint, of: Products.self)
        return observedProducts.map { $0 as ProductsProtocol }
    }
}
