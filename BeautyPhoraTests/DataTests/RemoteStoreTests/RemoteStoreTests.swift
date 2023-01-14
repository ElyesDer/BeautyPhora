//
//  RemoteStoreTests.swift
//  BeautyPhoraTests
//
//  Created by Derouiche Elyes on 13/01/2023.
//

import XCTest
@testable import BeautyPhora
import CoreData
import RxTest

final class RemoteStoreTests: XCTestCase {
    
    var remoteStore: ProductRemoteStoreProtocol!
    var provider: DataServiceProviderProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provider = Requester()
        remoteStore = ProductRemoteStore(requester: provider)
    }
    
    func test_get_products() async throws {
        
        // given
        let endpoint = Endpoint(method: .get, endURL: APIProvider.items)
        
        // execute
        guard let products = try provider
            .request(from: endpoint, of: Products.self)
            .asObservable()
            .toBlocking()
            .first() else {
            XCTFail("Failed to get products")
            return
        }
        
        // test
        XCTAssertTrue(!products.isEmpty)
    }
}
