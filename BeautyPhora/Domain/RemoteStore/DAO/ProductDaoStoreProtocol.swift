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
    func getProducts() throws -> PProducts
    func getProduct(id: Int) throws -> PProduct
    func insert(product: PProduct) throws
    func performUpdates(with products: Products)
    func remove(with id: Int)
}
