//
//  ProductDaoStore.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import CoreData

// swiftlint: disable identifier_name

protocol BaseDao <T, K> {
    associatedtype T: Decodable
    associatedtype K: NSManagedObject
    
    func encode(entity e: T, into obj: inout K)
    func decode(object o: K) -> T
}

class ProductDaoStore: BaseDao, ProductDaoStoreProtocol {
    
    typealias T = ProductDTO
    typealias K = Product
    
    func getAllProduct() async throws -> PProducts {
        // perform db fetch
        return []
    }
    
    func save(product: PProduct) throws {
        
    }
    
    // MARK: - Mapping DTO to managed objects
    
    func encode(entity e: ProductDTO, into obj: inout Product) {
        obj.id = Int32(e.id)
        obj.pName = e.name
        obj.pDescription = e.description
        obj.isSpecialBrand = e.isSpecialBrand
        obj.isProductSet = e.isProductSet
        obj.price = Int32(e.price)
        
        let brand = Brand()
        brand.id = e.brand.id
        brand.bName = e.brand.name
        
        obj.brand = brand
    }
    
    func decode(object o: Product) -> ProductDTO {
        return ProductDTO(
            id: Int(o.id),
            name: o.pName ?? "",
            description: o.pDescription ?? "",
            price: Int(o.price),
            image: ImagesURLDTO(small: o.imSmall ?? "", large: o.imLarge ?? ""),
            brand: BrandDTO(id: o.brand?.id ?? "", name: o.brand?.bName ?? ""),
            isProductSet: o.isProductSet,
            isSpecialBrand: o.isSpecialBrand)
    }
}
