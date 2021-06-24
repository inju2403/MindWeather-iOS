//
//  DiaryRepoImpl.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation
import RxSwift
import Alamofire

class DiaryRepoImpl: DiaryRepoType {
    
    let token = "JWT " + UserDefaults.standard.string(forKey: "token")!
    
    func getDiarys() -> Single<[Diary]> {
        return Single<[Diary]>.create { single in
            let urlString = K.API_BASE_URL + "diary/"
        
            AF.request(urlString,
                    method: .get,
                    headers: ["Authorization" : self.token]).responseJSON { response in
                    guard let value = response.value else {
                        return
                    }
                    single(.success([]))
            }
        
            return Disposables.create()
      }
    }
    
//    func getDiaryById(diaryId: String) -> Single<Diary> {
//        <#code#>
//    }
//    
//    func updateDiary(content: Content, diaryId: String) {
//        <#code#>
//    }
//    
//    func deleteDiary(diaryId: String) {
//        <#code#>
//    }
    
}
