//
//  Requester.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import Foundation
import RxSwift

// swiftlint: disable identifier_name

class Requester: DataServiceProviderProtocol {
    
    enum ServiceError: Error {
        case urlRequest
        case statusCodeError(Int)
        case responseError
        case decodingError
    }
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func request<T: Decodable>(from provider: NetworkProviderProtcol, of type: T.Type) -> Observable<T> {
        
        if let urlRequest: URLRequest = try? provider.buildURLRequest() {
            return Observable.create { observer in
                let task = self.urlSession.dataTask(with: urlRequest) { (data, response, _) in
                    if let httpResponse = response as? HTTPURLResponse {
                        let statusCode = httpResponse.statusCode
                        let _data = data ?? Data()
                        if (200...399).contains(statusCode) {
                            if let resultObject = try? JSONDecoder().decode(T.self, from: _data) {
                                observer.onNext(resultObject)
                            } else {
                                observer.onError(ServiceError.decodingError)
                            }
                        } else {
                            observer.onError(ServiceError.statusCodeError(statusCode))
                        }
                    }
                    observer.onCompleted()
                }
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
        } else {
            return Observable.error(ServiceError.urlRequest)
        }
    }
}
