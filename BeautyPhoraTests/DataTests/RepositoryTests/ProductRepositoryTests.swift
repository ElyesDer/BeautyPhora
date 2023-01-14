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
import RxSwift
import RxBlocking

final class ProductRepositoryTests: XCTestCase {
    
    var zut: ProductRepositoryProtocol!
    var localeStore: ProductDaoStoreProtocol!
    var remoteStore: ProductRemoteStoreProtocol!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        disposeBag = DisposeBag()
        let requester = Requester()
        localeStore = ProductDaoStore()
        remoteStore = ProductRemoteStore(requester: requester)
    }
    
    func test_get_all_locale_rx() async throws {
        
        class DependencyProvider: ProductLocalStoreProviderProtocol, ProductRemoteStoreProviderProtocol {
            var localStore: ProductDaoStoreProtocol
            var remoteStore: ProductRemoteStoreProtocol
            
            init(localStore: ProductDaoStoreProtocol, remoteStore: ProductRemoteStoreProtocol) {
                self.localStore = localStore
                self.remoteStore = remoteStore
            }
        }
        
        // setup expectation
        let expectation = XCTestExpectation(description: "Fetch Data")
        
        // given
        zut = ProductRepository(dependencies: DependencyProvider(localStore: localeStore, remoteStore: remoteStore))
        
        zut.getProduct()
            .subscribe({ event in
                switch event {
                    case .next(_): break
                    case .completed:
                        expectation.fulfill()
                    case .error(let error):
                        XCTFail("Failed with error \(error.localizedDescription)")
                        expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 40.0)
    }
}
