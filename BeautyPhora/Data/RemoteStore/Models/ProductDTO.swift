//
//  Product.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation

// MARK: - Product

typealias Products = [ProductDTO]

struct ProductDTO: PProduct {
    var id: Int
    var name: String
    var description: String
    var price: Int
    var image: PImagesURL
    var brand: PBrand
    var isProductSet: Bool
    var isSpecialBrand: Bool
}

extension ProductDTO {
    
    enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case name = "product_name"
        case description
        case price
        case image = "images_url"
        case brand = "c_brand"
        case isProductSet = "is_productSet"
        case isSpecialBrand = "is_special_brand"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        price = try values.decode(Int.self, forKey: .price)
        isProductSet = try values.decode(Bool.self, forKey: .isProductSet)
        isSpecialBrand = try values.decode(Bool.self, forKey: .isSpecialBrand)
        image = try values.decode(ImagesURLDTO.self, forKey: .image)
        brand = try values.decode(BrandDTO.self, forKey: .brand)
    }
}
