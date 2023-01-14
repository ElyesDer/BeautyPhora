//
//  HomeViewModelTests.swift
//  BeautyPhoraTests
//
//  Created by Derouiche Elyes on 14/01/2023.
//

import XCTest
@testable import BeautyPhora
import RxSwift
import RxBlocking

class HomeViewModelTests: XCTestCase {
    
    var homeViewModel: HomeViewModel!
    var mockProductRepository: MockProductRepository!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        disposeBag = DisposeBag()
        mockProductRepository = MockProductRepository()
        homeViewModel = HomeViewModel(productRepository: mockProductRepository)
    }
    
    func test_FetchNormalProduct() {
        
        // Arrange
        let expectedProducts = StubProvider.instance.products.filter { !$0.isSpecialBrand }
        mockProductRepository.products = expectedProducts
        
        // Act
        homeViewModel.fetchProduct()
        
        // Assert
        guard let products = try? homeViewModel.productList.asObservable().toBlocking().first() else {
            XCTFail("Failed to request")
            return
        }
        XCTAssertEqual(products.count, expectedProducts.count)
    }
}

class MockProductRepository: ProductRepositoryProtocol {
    
    var products = [ProductDTO]()
    
    func getProducts() async throws -> ProductsProtocol {
        return []
    }
    
    func getProduct() -> Observable<ProductsProtocol> {
        return .create { observer in
            observer.onNext(StubProvider.instance.products)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
