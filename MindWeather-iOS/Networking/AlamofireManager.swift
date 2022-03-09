//
//  AlamofireManager.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/20.
//

import Alamofire

struct AlamofireManager {
    
    //interceptors
    let interceptors = Interceptor(interceptors: [BaseInterceptor()])
    
    //logger
    let monitors = [AlamofireLogger()] as [EventMonitor]
    
    //session
    var session = Session()
    
    init() {
        session = Session(
            interceptor: interceptors,
            eventMonitors: monitors
        )
    }
}
