//
//  ProductRemoteStoreProtocol.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

protocol ProductRemoteStoreProviderProtocol {
    var remoteStore: ProductRemoteStoreProtocol { get }
}

protocol ProductRemoteStoreProtocol {
    func getProducts() -> Observable<ProductsProtocol>
}
