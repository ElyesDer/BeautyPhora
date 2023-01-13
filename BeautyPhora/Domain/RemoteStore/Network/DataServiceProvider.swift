//
//  DataServiceProvider.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

protocol HasDataServiceProviderProtocol {
    var requester: DataServiceProviderProtocol { get }
}

protocol DataServiceProviderProtocol {
    var urlSession: URLSession { get }
    func request<T>(from provider: NetworkProviderProtcol, of type: T.Type) async throws -> T where T: Decodable
    func requestRx<T>(from provider: NetworkProviderProtcol, of type: T.Type) -> Observable<T> where T: Decodable
}
