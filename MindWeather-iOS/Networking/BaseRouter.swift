//
//  BaseRouter.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation

import Alamofire

enum BaseRouter: URLRequestConvertible {
    
    case diarys
    case diary
    case updateDiary
    case deleteDiary
    
    var baseURL: URL {
        return URL(string: K.API_BASE_URL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .diarys, .diary:
            return .get
        case .updateDiary:
            return .patch
        case .deleteDiary:
            return .delete
        }
    }
    
    var endPoint: String {
        switch self {
        case .diarys, .diary, .updateDiary, .deleteDiary:
            return "diary/"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
}
