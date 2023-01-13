//
//  ProductListViewModel.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 13/01/2023.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel: HasProductRepositoryProtocol {
    
    enum ProductListViewModelState {
        case idle
        case loading
        case error (String)
    }
    
    var productRepository: ProductRepositoryProtocol
    
    private let disposeBag = DisposeBag()
    var productList = BehaviorRelay<Products>(value: [])
    var state = BehaviorRelay<ProductListViewModelState>(value: .idle)
    
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
                        self.productList.accept(products)
                    case .completed:
                        self.state.accept(.idle)
                    case .error(let error):
                        self.state.accept(.error(error.localizedDescription))
                }
            })
            .disposed(by: disposeBag)
    }
}
