//
//  BaseRouter.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Alamofire

enum AlamofireRouter: URLRequestConvertible {

    case diarys
    case diary(diaryId: Int)
    case updateDiary(diaryId: Int, content: Content)
    case deleteDiary(diaryId: Int)
    
    var baseURL: URL {
        return URL(string: Constant.APIBaseUrl)!
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
        case .diarys:
            return "diary/"
        case let .diary(diaryId):
            return "diary/\(diaryId)/"
        case let .updateDiary(diaryId, _):
            return "diary/\(diaryId)/"
        case let .deleteDiary(diaryId):
            return "diary/\(diaryId)/"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .diarys, .diary, .deleteDiary:
            break
        case let .updateDiary(_, content):
            request = try URLEncodedFormParameterEncoder().encode(content, into: request)
        }

        return request
    }
}
