//
//  ProductDAOProtocol.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

protocol ProductLocalStoreProviderProtocol {
    var localStore: ProductDaoStoreProtocol { get }
}

protocol ProductDaoStoreProtocol {
    func getProducts() throws -> ProductsProtocol
    func getProduct(id: Int) throws -> ProductProtocol
    func insert(product: ProductProtocol) throws
    func performUpdates(with products: ProductsProtocol)
    func removeAll(in entity: String)
}
