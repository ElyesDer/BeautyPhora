//
//  PProduct.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

typealias PProducts = [PProduct]

protocol PProduct: Decodable {
    var id: Int { get }
    var name: String { get }
    var description: String { get }
    var price: Int { get }
    var image: PImagesURL { get }
    var brand: PBrand { get }
    var isProductSet: Bool { get }
    var isSpecialBrand: Bool { get }
}

//extension PProduct: Hashable {
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(self.id)
//    }
//}

protocol PImagesURL: Codable {
    var small: String { get }
    var large: String { get }
}

protocol PBrand: Codable {
    var id: String { get }
    var name: String { get }
}
