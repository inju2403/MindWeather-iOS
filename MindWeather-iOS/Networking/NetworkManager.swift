//
//  NetworkManager.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2022/03/09.
//

import Alamofire
import RxSwift

struct NetworkManager {

    private init() {}

    static let shared = NetworkManager()
    let alamofireManager = AlamofireManager()

    func requestModel<T: Decodable>(type: T.Type, router: AlamofireRouter, single: @escaping Single<T>.SingleObserver) {
        alamofireManager
            .session
            .request(router)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    single(.success(value))
                case .failure(let error):
                    single(.failure(error))
                }
            }
    }

    func requestEmptyResponse(router: AlamofireRouter, single: @escaping Single<Bool>.SingleObserver) {
        alamofireManager
            .session
            .request(router)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    single(.success(true))
                case .failure(let error):
                    single(.failure(error))
                }
            }
    }
}
