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
        
        //로그인, 회원가입을 제외한 api 헤더에 Authorization(jwt) 추가 예정 - UserDefaults에서 갖고 오기
//        request.addValue(jwt, forHTTPHeaderField: "Authorization")
        completion(.success(request))
        
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}

