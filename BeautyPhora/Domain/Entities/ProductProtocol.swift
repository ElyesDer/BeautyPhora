//
//  PProduct.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

typealias ProductsProtocol = [ProductProtocol]

protocol ProductProtocol: Decodable {
    var id: String { get }
    var name: String { get }
    var description: String { get }
    var price: Int { get }
    var image: ImagesProtocol { get }
    var brand: BrandProtocol { get }
    var isProductSet: Bool { get }
    var isSpecialBrand: Bool { get }
}

protocol ImagesProtocol: Codable {
    var small: String { get }
    var large: String { get }
}

protocol BrandProtocol: Codable {
    var id: String { get }
    var name: String { get }
}
