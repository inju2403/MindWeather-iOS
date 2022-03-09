//
//  AlamofireLogger.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Alamofire

struct AlamofireLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "BaseLogger")
    
    func requestDidResume(_ request: Request) {
        debugPrint(request)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint(response)
    }
}
