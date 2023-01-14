//
//  LocaleStoreTests.swift
//  BeautyPhoraTests
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import XCTest
@testable import BeautyPhora
import CoreData
import RxTest

final class LocaleStoreTests: XCTestCase {
    
    var localeStore: ProductDaoStoreProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        localeStore = ProductDaoStore()
    }
    
    func test_get_all_locale_rx() throws {
        let products = try? localeStore.getProducts()
        
        XCTAssertNotNil(products)
    }
    
    func test_get_all_locale() throws {
        let products = try? localeStore.getProducts()
        
        XCTAssertNotNil(products)
    }
    
    func test_save_get_products_locale() throws {
        
        // prepare stub
        guard let random = StubProvider.instance.products.randomElement() else {
            XCTFail("Could not grab element")
            return
        }
        
        XCTAssertNotNil(try? localeStore.insert(product: random), "Save failed with error")
        
        // lets try to grab saved random
        guard let savedRandom = try? localeStore.getProduct(id: Int(random.id) ?? 0) else {
            XCTFail("Failed to grab product from local store")
            return
        }
        
        XCTAssertTrue(savedRandom.id == random.id)
    }
}
