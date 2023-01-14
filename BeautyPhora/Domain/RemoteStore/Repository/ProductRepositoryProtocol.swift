//
//  ProductRepositoryProtocol.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

protocol HasProductRepositoryProtocol {
    var productRepository: ProductRepositoryProtocol { get }
}

protocol ProductRepositoryProtocol {
    func getProduct() -> Observable<PProducts>
}
