//
//  ViewModelFactory.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 13/01/2023.
//

import Foundation

protocol ViewModelFactoryProtocol: DataServiceRequesterProviderProtocol, ProductRemoteStoreProviderProtocol, ProductLocalStoreProviderProtocol {}

class ViewModelFactory: ViewModelFactoryProtocol {
    var remoteStore: ProductRemoteStoreProtocol
    var localStore: ProductDaoStoreProtocol
    var requester: DataServiceProviderProtocol
    
    init(requester: DataServiceProviderProtocol = Requester()) {
        self.requester = Requester()
        self.remoteStore = ProductRemoteStore(requester: self.requester)
        self.localStore = ProductDaoStore()
    }
    
    func buildHomeViewModel() -> HomeViewModel {
        let repository = ProductRepository(dependencies: self)
        let productUseCases = ProductUseCases(productRepository: repository)
        return HomeViewModel(productUsesCases: productUseCases)
    }
}
