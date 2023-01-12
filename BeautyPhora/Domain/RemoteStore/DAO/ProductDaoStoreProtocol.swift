//
//  ProductDAOProtocol.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

protocol HasProductDaoStoreProtocol {
    var localStore: ProductDaoStoreProtocol { get }
}

protocol ProductDaoStoreProtocol {
    func getAllProduct() async throws -> PProducts
    func save(product: PProduct) throws
}
