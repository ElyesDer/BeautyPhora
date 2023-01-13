//
//  ProductListViewModel.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 13/01/2023.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

struct SectionViewModel {
    var header: String!
    var items: Products
}

extension SectionViewModel: SectionModelType {
    typealias Item  = ProductDTO
    init(original: SectionViewModel, items: Products) {
        self = original
        self.items = items
    }
}

class HomeViewModel: HasProductRepositoryProtocol {
    
    enum ProductListViewModelState {
        case idle
        case loading
        case error (String)
    }
    
    var productRepository: ProductRepositoryProtocol
    
    private let disposeBag = DisposeBag()
    private(set) var productList = BehaviorRelay<Products>(value: [])
    private(set) var favoriteProductList = BehaviorRelay<Products>(value: [])
    
    var state = BehaviorRelay<ProductListViewModelState>(value: .idle)
    var sectionModels = BehaviorRelay<[SectionViewModel]>(value: [])
    
    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
        
        // fetch
        fetchProduct()
    }
}

extension HomeViewModel {
    func fetchProduct() {
        self.productRepository
            .getProductRx()
            .compactMap { $0 as? Products }
            .subscribe({ event in
                switch event {
                    case .next(let products):
                        self.productList.accept(products.filter { !$0.isSpecialBrand } )
                        self.favoriteProductList.accept(products.filter { $0.isSpecialBrand } )
                        
                        var prepareSection: [SectionViewModel] = []
                        prepareSection.append(.init(header: "Specials", items: self.favoriteProductList.value))
                        prepareSection.append(.init(header: "Products", items: self.productList.value))
                        self.sectionModels.accept(prepareSection)
                    case .completed:
                        self.state.accept(.idle)
                    case .error(let error):
                        self.state.accept(.error(error.localizedDescription))
                }
            })
            .disposed(by: disposeBag)
    }
}
