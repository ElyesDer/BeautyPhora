//
//  ProductListViewModel.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 13/01/2023.
//

import Foundation
import RxSwift
import RxRelay

protocol HomeViewModelProtocol: ProductUseCasesProviderProtocol {
    var productList: BehaviorRelay<Products> { get }
    var favoriteProductList: BehaviorRelay<Products> { get }
    var state: BehaviorRelay<ProductListViewModelState> { get }
    var sectionModels: BehaviorRelay<[SectionViewModel]> { get }
    func fetchProduct()
}

class HomeViewModel: HomeViewModelProtocol {
    
    var productUsesCases: ProductUseCasesProtocol
    
    private let disposeBag = DisposeBag()
    private(set) var productList = BehaviorRelay<Products>(value: [])
    private(set) var favoriteProductList = BehaviorRelay<Products>(value: [])
    
    var state = BehaviorRelay<ProductListViewModelState>(value: .idle)
    var sectionModels = BehaviorRelay<[SectionViewModel]>(value: [])
    
    init(productUsesCases: ProductUseCasesProtocol) {
        self.productUsesCases = productUsesCases
        
        // fetch
        fetchProduct()
    }
}

extension HomeViewModel {
    func fetchProduct() {
        self.productUsesCases
            .getProducts()
            .compactMap { $0 as? Products }
            .subscribe { observer in
                switch observer {
                    case .next(let products):
                        self.productList
                            .accept(products.filter { !$0.isSpecialBrand } )
                        self.favoriteProductList
                            .accept(products.filter { $0.isSpecialBrand } )
                        
                        var prepareSection: [SectionViewModel] = []
                        prepareSection
                            .append(.init(header: "Specials", items: self.favoriteProductList.value
                                .map { ProductModel(product: $0) }
                            ))
                        prepareSection
                            .append(.init(header: "Products", items: self.productList.value
                                .map { ProductModel(product: $0) }
                            ))
                        self.sectionModels.accept(prepareSection)
                    case .completed:
                        self.state.accept(.idle)
                    case .error(let error):
                        self.state.accept(.error(error.localizedDescription))
                }
            }
            .disposed(by: disposeBag)
    }
}
