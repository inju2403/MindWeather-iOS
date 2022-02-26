//
//  DiaryRepoImpl.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation

import Alamofire
import RxSwift

class DiaryRepoImpl: DiaryRepo {
    
    func diarys() -> Single<[Diary]> {
        return Single<[Diary]>.create { [weak self] single in
            let urlString = Constant.API_BASE_URL + "diary/"

            AF.request(urlString,
                       method: .get,
                       headers: ["Authorization" : Constant.token()])
                .responseDecodable(of: [Diary].self) { response in
                    guard let value = response.value else {
                        single(.failure(response.error!))
                        return
                    }
                    single(.success(value))
                }

            return Disposables.create()
        }
    }
    
    func diary(diaryId: Int) -> Single<Diary> {
        return Single<Diary>.create { [weak self] single in
            let urlString = Constant.API_BASE_URL + "diary/\(diaryId)/"
        
            AF.request(urlString,
                       method: .get,
                       headers: ["Authorization" : Constant.token()])
                .responseDecodable(of: Diary.self) { response in
                    guard let value = response.value else {
                        single(.failure(response.error!))
                        return
                    }
                    single(.success(value))
                }
            
            return Disposables.create()
        }
    }
    
    func updateDiary(content: Content, diaryId: Int) -> Single<Bool> {
        return Single<Bool>.create { [weak self] single in
            let urlString = Constant.API_BASE_URL + "diary/\(diaryId)/"

            AF.request(urlString,
                       method: .patch,
                       parameters: content,
                       encoder: JSONParameterEncoder(),
                       headers: ["Authorization" : Constant.token()])
                .responseJSON {  response in
                    switch response.response?.statusCode {
                    case 200:
                        single(.success(true))
                        break
                    case 400:
                        single(.failure(response.error!))
                        break
                    default:
                        break
                    }
                }
            
            return Disposables.create()
        }
    }
    
    func deleteDiary(diaryId: Int) -> Single<Bool> {
        return Single<Bool>.create { [weak self] single in
            let urlString = Constant.API_BASE_URL + "diary/\(diaryId)/"

            AF.request(urlString,
                       method: .delete,
                       headers: ["Authorization" : Constant.token()])
                .responseJSON {  response in
                    switch response.response?.statusCode {
                    case 204:
                        single(.success(true))
                        break
                    case 400:
                        single(.failure(response.error!))
                        break
                    default:
                        break
                    }
                }
            
            return Disposables.create()
        }
    }
    
}
