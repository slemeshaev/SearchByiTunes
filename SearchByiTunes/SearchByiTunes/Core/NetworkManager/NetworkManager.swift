//
//  NetworkManager.swift
//  SearchByiTunes
//
//  Created by Станислав Лемешаев on 02.07.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    public typealias DataCompletion = (Result<Data>) -> Void
    public typealias JSONCompletion = (Result<[String: Any]?>) -> Void
    
    public func dataRequest(_ request: WebRequest, then completion: DataCompletion?) {
        AF.request(request.url, method: request.method, parameters: request.parameters).validate().responseData { [weak self] response in
            response.result
                .withValue { data in
                    completion?(.success(data))
                }
                .withError {
                    self?.logError($0, request: request)
                    completion?(.failure($0))
            }
        }
    }
    
    public func jsonRequest(_ request: WebRequest, then completion: JSONCompletion?) {
        AF.request(request.url, method: request.method, parameters: request.parameters).validate().responseJSON { [weak self] response in
            response.result
                .withValue { json in
                    completion?(.success(json as? [String: Any]))
                }
                .withError {
                    self?.logError($0, request: request)
                    completion?(.failure($0))
            }
        }
    }
    
    private func logError(_ error: Error, request: WebRequest) {
        print("Error while executing request \(request.url), error: \(error.localizedDescription)")
    }
}
