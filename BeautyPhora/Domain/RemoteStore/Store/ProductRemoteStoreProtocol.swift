//
//  ProductRemoteStoreProtocol.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

protocol HasProductRemoteStoreProtocol {
    var remoteStore: ProductRemoteStoreProtocol { get }
}

protocol ProductRemoteStoreProtocol {
    func getProducts() async throws -> PProducts
    func getProducts() -> Observable<PProducts>
}
