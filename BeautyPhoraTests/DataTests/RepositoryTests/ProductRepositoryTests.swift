//
//  ProductRepositoryTests.swift
//  BeautyPhoraTests
//
//  Created by Derouiche Elyes on 13/01/2023.
//

import XCTest
@testable import BeautyPhora
import CoreData
import RxTest

final class ProductRepositoryTests: XCTestCase {
    
    var zut: ProductRepositoryProtocol!
    var localeStore: ProductDaoStoreProtocol!
    var remoteStore: ProductRemoteStoreProtocol!
    //    let bag: DisposeBag!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let requester = Requester()
        localeStore = ProductDaoStore()
        remoteStore = ProductRemoteStore(requester: requester)
    }
    
    func test_get_all_locale_rx() async throws {
        
        class DependencyProvider: HasProductDaoStoreProtocol, HasProductRemoteStoreProtocol {
            var localStore: BeautyPhora.ProductDaoStoreProtocol
            var remoteStore: BeautyPhora.ProductRemoteStoreProtocol
            
            init(localStore: BeautyPhora.ProductDaoStoreProtocol, remoteStore: BeautyPhora.ProductRemoteStoreProtocol) {
                self.localStore = localStore
                self.remoteStore = remoteStore
            }
        }
        
//        let bag = DisposeBag()
        
        // setup expectation
        let expectation = XCTestExpectation(description: "Fetch Data")
        
        // given
        zut = ProductRepository(dependencies: DependencyProvider(localStore: localeStore, remoteStore: remoteStore))
        
        let _ = zut.getProductRx()
            .subscribe({ event in
                switch event {
                    case .next(let products):
                        XCTAssertFalse(products.isEmpty)
                    case .completed:
                        expectation.fulfill()
                    case .error(let error):
                        XCTFail("Failed with error \(error.localizedDescription)")
                        expectation.fulfill()
                }
            })
        
        wait(for: [expectation], timeout: 40.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
