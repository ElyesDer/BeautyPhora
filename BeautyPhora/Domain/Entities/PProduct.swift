//
//  PProduct.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

typealias PProducts = [PProduct]

protocol PProduct: Decodable {
    var id: String { get }
    var name: String { get }
    var description: String { get }
    var price: Int { get }
    var image: PImagesURL { get }
    var brand: PBrand { get }
    var isProductSet: Bool { get }
    var isSpecialBrand: Bool { get }
}

protocol PImagesURL: Codable {
    var small: String { get }
    var large: String { get }
}

protocol PBrand: Codable {
    var id: String { get }
    var name: String { get }
}
