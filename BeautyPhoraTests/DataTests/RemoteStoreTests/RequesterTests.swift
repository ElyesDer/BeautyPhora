//
//  Request_tests.swift
//  BeautyPhoraTests
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import XCTest
@testable import BeautyPhora

final class RequesterTests: XCTestCase {
    
    var endpoint: NetworkProviderProtcol!
    var requester: DataServiceProviderProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_get_product_success() async throws {
        
        // prepare stub
        guard let random = StubProvider.instance.productEndpoints.randomElement(), let data = random.content.data(using: .utf8) else {
            assertionFailure("Can't find a valid stub element to test")
            return
        }
        
        // init endpoint
        endpoint = Endpoint(method: .get, endURL: APIProvider.items)
        
        // prepare mock configuration
        MockURLProtocol.requestHandler = { urlRequest in
            guard let url = urlRequest.url, url == random.endpoint else {
                throw Requester.ServiceError.urlRequest
            }
            
            let response = HTTPURLResponse(url: random.endpoint, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // assign configuration
        let configuration: URLSessionConfiguration = .default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        // setup requester
        requester = Requester(urlSession: urlSession)
        
        // execute
        guard let products = try requester
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
    
    func test_get_products_error_404() async throws {
        
        // prepare stub
        guard let randomLeague = StubProvider.instance.productEndpoints.randomElement(), let data = randomLeague.content.data(using: .utf8) else {
            assertionFailure("Can't find a valid stub element to test")
            return
        }
        
        // init endpoint
        endpoint = Endpoint(method: .get, endURL: APIProvider.items)
        
        // prepare mock configuration
        MockURLProtocol.requestHandler = { urlRequest in
            guard let url = urlRequest.url, url == randomLeague.endpoint else {
                throw Requester.ServiceError.urlRequest
            }
            
            let response = HTTPURLResponse(url: randomLeague.endpoint, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // assign configuration
        let configuration: URLSessionConfiguration = .default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        // setup requester
        requester = Requester(urlSession: urlSession)
        
        // execute
        do {
            _ = try requester
                .request(from: endpoint, of: Products.self)
                .asObservable()
                .toBlocking()
                .first()
            
            XCTFail("Request should not succeed")
        } catch {
            guard let error = error as? Requester.ServiceError else {
                XCTFail("Different error from service thrown")
                return
            }
            
            if case Requester.ServiceError.statusCodeError(404) = error {
                return
            } else {
                XCTFail("ServiceError.statusCodeError different fron 404")
            }
        }
    }
}
