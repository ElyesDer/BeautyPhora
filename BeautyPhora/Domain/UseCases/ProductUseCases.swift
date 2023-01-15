//
//  ProductUseCases.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 15/01/2023.
//

import Foundation
import RxSwift

protocol ProductUseCasesProviderProtocol {
    var productUsesCases: ProductUseCasesProtocol { get }
}

protocol ProductUseCasesProtocol {
    func getProducts() -> Observable<ProductsProtocol>
}

final class ProductUseCases: ProductUseCasesProtocol, ProductRepositoryProviderProtocol {
    
    var productRepository: ProductRepositoryProtocol
    
    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }
    
    func getProducts() -> Observable<ProductsProtocol> {
        return self.productRepository
            .getProduct()
    }
}
