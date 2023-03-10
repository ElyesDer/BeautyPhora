//
//  ProductRepository.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

class ProductRepository: ProductRepositoryProtocol, ProductRemoteStoreProviderProtocol, ProductLocalStoreProviderProtocol {
    
    var localStore: ProductDaoStoreProtocol
    var remoteStore: ProductRemoteStoreProtocol
    
    typealias Dependencies = ProductLocalStoreProviderProtocol & ProductRemoteStoreProviderProtocol
    
    init(dependencies: Dependencies) {
        self.localStore = dependencies.localStore
        self.remoteStore = dependencies.remoteStore
    }
    
    func getProduct() -> Observable<ProductsProtocol> {
        let localData = (try? localStore.getProducts()) ?? []
        return Observable.of(
            Observable.create({ observer in
                observer.onNext(localData)
                observer.onCompleted()
                return Disposables.create()
            }),
            .create({ observer in
                self.remoteStore.getProducts()
                    .compactMap { $0 as? Products }
                    .subscribe { event in
                        switch event {
                            case .next(let products):
                                self.localStore.performUpdates(with: products as Products)
                                observer.onNext(products)
                            case .error(let error):
                                observer.onError(error)
                            case .completed:
                                observer.onCompleted()
                        }
                    }
            })
        ).merge()
        
    }
}
