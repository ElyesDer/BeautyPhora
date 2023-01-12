//
//  ProductRepository.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

class ProductRepository: ProductRepositoryProtocol, HasProductRemoteStoreProtocol, HasProductDaoStoreProtocol {
    
    var localStore: ProductDaoStoreProtocol
    var remoteStore: ProductRemoteStoreProtocol
    
    typealias Dependencies = HasProductDaoStoreProtocol & HasProductRemoteStoreProtocol
    
    init(dependencies: Dependencies) {
        self.localStore = dependencies.localStore
        self.remoteStore = dependencies.remoteStore
    }
    
    func getProducts() async throws -> Products {
        // plz request local db
        return try await remoteStore.getProducts()
    }
}
