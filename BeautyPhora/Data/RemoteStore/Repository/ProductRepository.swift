//
//  ProductRepository.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

class ProductRepository: ProductRepositoryProtocol, HasProductRemoteStoreProtocol {
    
    var remoteStore: ProductRemoteStoreProtocol
    
    init(remoteStore: ProductRemoteStoreProtocol) {
        self.remoteStore = remoteStore
    }
    
    func getProducts() async throws -> Products {
        // plz request local db
        return try await remoteStore.getProducts()
    }
}
