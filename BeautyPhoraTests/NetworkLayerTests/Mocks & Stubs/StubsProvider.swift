//
//  StubsProvider.swift
//  BeautyPhoraTests
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
@testable import BeautyPhora

// swiftlint:disable all line_length

typealias StubEndpoints = [StubEndpoint]

struct StubEndpoint {
    var endpoint: URL
    var content: String
}

class StubProvider {
    
    static var instance = StubProvider()
    
    var products: Products = []
    
    var productEndpoints: StubEndpoints = []
    
    private init() {
        for _ in 0...5 {
            products.append(
                Product(id: Int.random(in: 0...100), name: "productName-\(Int.random(in: 0...100))", description: "description-\(Int.random(in: 0...100))", price: Int.random(in: 0...200), image: ImagesURL(small: "https://dev.sephora.fr/on/demandware.static/-/Library-Sites-SephoraV2/default/dw521a3f33/brands/institbanner/SEPHO_900_280_institutional_banner_20210927_V2.jpg", large: ""), brand: Brand(id: "id-\(Int.random(in: 0...10))", name: "name-\(Int.random(in: 0...100))"), isProductSet: Bool.random(), isSpecialBrand: Bool.random()))
        }
        
        productEndpoints
            .append(
                .init(endpoint: URL(string: "https://sephoraios.github.io/items.json")!,
                      content: """
                  [
                    {
                      "product_id": 1461267310,
                      "product_name": "Size Up - Mascara Volume Extra Large Immédiat",
                      "description": "Craquez pour le Mascara Size Up de Sephora Collection : Volume XXL immédiat, cils ultra allongés et recourbés ★ Formule vegan longue tenue ✓",
                      "price": 140,
                      "images_url": {
                        "small": "https://dev.sephora.fr/on/demandware.static/-/Library-Sites-SephoraV2/default/dw521a3f33/brands/institbanner/SEPHO_900_280_institutional_banner_20210927_V2.jpg",
                        "large": ""
                      },
                      "c_brand": {
                        "id": "SEPHO",
                        "name": "SEPHORA COLLECTION"
                      },
                      "is_productSet": false,
                      "is_special_brand": false
                    },
                    {
                      "product_id": 1461267314,
                      "product_name": "Kit bain fleur de coton",
                      "description": "Un gel nettoyant mains qui lave vos mains tout en douceur avec sa mousse aussi onctueuse que généreuse.",
                      "price": 120,
                      "images_url": {
                        "small": "https://dev.sephora.fr/on/demandware.static/-/Library-Sites-SephoraV2/default/dw521a3f33/brands/institbanner/SEPHO_900_280_institutional_banner_20210927_V2.jpg",
                        "large": ""
                      },
                      "c_brand": {
                        "id": "SEPHO",
                        "name": "SEPHORA COLLECTION"
                      },
                      "is_productSet": true,
                      "is_special_brand": false
                    },
                    {
                      "product_id": 1461267315,
                      "product_name": "Kit bain fleur de coton",
                      "description": "Un gel nettoyant mains qui lave vos mains tout en douceur avec sa mousse aussi onctueuse que généreuse.",
                      "price": 120,
                      "images_url": {
                        "small": "https://dev.sephora.fr/on/demandware.static/-/Library-Sites-SephoraV2/default/dw521a3f33/brands/institbanner/SEPHO_900_280_institutional_banner_20210927_V2.jpg",
                        "large": ""
                      },
                      "c_brand": {
                        "id": "SEPHO",
                        "name": "SEPHORA COLLECTION"
                      },
                      "is_productSet": true,
                      "is_special_brand": false
                    }
                  ]
                  """))
    }
}

