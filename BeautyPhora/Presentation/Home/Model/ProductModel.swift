//
//  Product.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 14/01/2023.
//

import Foundation

typealias ProductModels = [ProductModel]

struct ProductModel {
    var title: String
    var description: String
    var price: String
    var isSpecialBrand: Bool
    var previewSmallImage: URL?
    
    init(product: PProduct) {
        self.title = product.name
        self.description = product.description
        self.isSpecialBrand = product.isSpecialBrand
        self.previewSmallImage = URL(string: product.image.small.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? String())
        self.price = product.price.formatted(.currency(code: "EUR"))
    }
}
