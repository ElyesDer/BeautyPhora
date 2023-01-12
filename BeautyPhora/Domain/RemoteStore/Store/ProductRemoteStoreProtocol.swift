//
//  ProductRemoteStoreProtocol.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

protocol HasProductRemoteStoreProtocol {
    var remoteStore: ProductRemoteStoreProtocol { get }
}

protocol ProductRemoteStoreProtocol {
    func getProducts() async throws -> Products
}
