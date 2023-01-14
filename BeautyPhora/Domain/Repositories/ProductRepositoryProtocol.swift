//
//  ProductRepositoryProtocol.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

protocol ProductRepositoryProviderProtocol {
    var productRepository: ProductRepositoryProtocol { get }
}

protocol ProductRepositoryProtocol {
    func getProduct() -> Observable<ProductsProtocol>
}
