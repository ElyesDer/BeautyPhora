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
    
    public func requestRx<T: Decodable>(from provider: NetworkProviderProtcol, of type: T.Type) -> Observable<T> {
        
        if let urlRequest: URLRequest = try? provider.buildURLRequest() {
            return Observable.create { observer in
                let task = self.urlSession.dataTask(with: urlRequest) { (data, response, error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        let statusCode = httpResponse.statusCode
                        do {
                            let _data = data ?? Data()
                            if (200...399).contains(statusCode) {
                                
                                if let resultObject = try? JSONDecoder().decode(T.self, from: _data) {
                                    observer.onNext(resultObject)
                                } else {
                                    observer.onError(ServiceError.decodingError)
                                }
                            } else {
                                observer.onError(error!)
                            }
                        } catch {
                            observer.onError(error)
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
    
    func request<T>(from provider: NetworkProviderProtcol, of type: T.Type) async throws -> T where T: Decodable {
        
        guard let urlRequest: URLRequest = try? provider.buildURLRequest() else {
            throw ServiceError.urlRequest
        }
        
        let sessionResponse = try await urlSession.data(for: urlRequest)
        
        // handle errors
        guard let response = sessionResponse.1 as? HTTPURLResponse else {
            throw ServiceError.responseError
        }
        
        guard response.statusCode == 200 else {
            throw ServiceError.statusCodeError(response.statusCode)
        }
        
        guard let resultObject = try? JSONDecoder().decode(T.self, from: sessionResponse.0) else {
            throw ServiceError.decodingError
        }
        return resultObject
    }
}
