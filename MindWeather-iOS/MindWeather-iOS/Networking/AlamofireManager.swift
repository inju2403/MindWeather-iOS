//
//  AlamofireManager.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/20.
//

import Foundation
import Alamofire

final class AlamofireManager {
    
    // Singleton Pattern
    static let shared = AlamofireManager()
    
    //interceptors
    let interceptors = Interceptor(interceptors: [BaseInterceptor()])
    
    //session
    var session = Session()
    
    private init() {
        session = Session(interceptor: interceptors)
    }
}
