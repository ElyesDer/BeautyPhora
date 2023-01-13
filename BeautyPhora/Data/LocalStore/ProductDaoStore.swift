//
//  ProductDaoStore.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import CoreData

// swiftlint: disable identifier_name

protocol BaseDao<T, K> {
    associatedtype T: Decodable
    associatedtype K: NSManagedObject
    
    var container: NSPersistentContainer { get }
    func encode(entity e: T, into obj: inout K)
    func decode(object o: K) -> T
}

class ProductDaoStore: BaseDao, ProductDaoStoreProtocol {
    
    typealias T = ProductDTO
    typealias K = Product
    
    let container: NSPersistentContainer
    
    enum ProductDaoStoreError: Error {
        case notFoundError
        case encodeError
        case decodeError
    }
    
    init(inMemory: Bool = false, container: NSPersistentContainer = NSPersistentContainer(name: "BeautyPhora")) {
        self.container = container
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        self.container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.container.viewContext.automaticallyMergesChangesFromParent = true
        self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func performUpdates(with products: Products) {
//        products.forEach { product in
//            remove(with: product.id)
//            print("inserting \(product.id)")
//            try? insert(product: product)
//        }
        removeAll(in: "Product")
        products.forEach { product in
            try? insert(product: product)
        }
    }
    
    func removeAll(in entity : String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try self.container.viewContext.execute(deleteRequest)
            try self.container.viewContext.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func remove(with id: Int) {
        print("removing \(id)")
    }
    
    func getProducts() throws -> PProducts {
        // perform db fetch
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        return try self.container.viewContext
            .fetch(fetchRequest)
            .map {
                return decode(object: $0)
            }
    }
    
    func getProduct(id: Int) throws -> any PProduct {
        let fetchRequest: NSFetchRequest<Product> = NSFetchRequest(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.fetchLimit = 1
        guard let product = try self.container.viewContext.fetch(fetchRequest).first else {
            throw ProductDaoStoreError.notFoundError
        }
        return self.decode(object: product)
    }
    
    func insert(product: any PProduct) throws {
        var localProduct: Product = .init(context: self.container.viewContext)
        guard let dto = product as? ProductDTO else { throw NSError() }
        encode(entity: dto, into: &localProduct)
        try self.container.viewContext.saveIfNeeded()
    }
    
    // MARK: - Mapping DTO to managed objects
    
    func encode(entity e: ProductDTO, into obj: inout Product) {
        obj.id = Int32(e.id)
        obj.pName = e.name
        obj.pDescription = e.description
        obj.isSpecialBrand = e.isSpecialBrand
        obj.isProductSet = e.isProductSet
        obj.price = Int32(e.price)
        
        let brand = Brand(context: self.container.viewContext)
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
