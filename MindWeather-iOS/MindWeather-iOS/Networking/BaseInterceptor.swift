//
//  BaseInterceptor.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/20.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var request = urlRequest
        
        request.addValue("application/json; charset=UTP-8", forHTTPHeaderField: "Content-type")
        request.addValue("application/json; charset=UTP-8", forHTTPHeaderField: "Accept")
        
        completion(.success(request))
        
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}

