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

    func request<T: Decodable>(type: T.Type, router: AlamofireRouter, single: @escaping Single<T>.SingleObserver) {
        alamofireManager
            .session
            .request(router)
            .responseDecodable(of: T.self) { response in
                guard let statusCode = response.response?.statusCode else {
                    single(.failure(response.error!))
                    return
                }

                switch statusCode {
                case 200...299:
                    single(.success(response.value ?? true as! T))
                    break
                default:
                    single(.failure(response.error!))
                    break
                }
            }
    }
}
