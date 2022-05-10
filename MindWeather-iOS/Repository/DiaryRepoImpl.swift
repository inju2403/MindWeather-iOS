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
        return Single<[Diary]>.create { single in
            NetworkManager.shared.requestModel(
                type: [Diary].self,
                router: AlamofireRouter.diarys,
                single: single
            )

            return Disposables.create()
        }
    }
    
    func diary(diaryId: Int) -> Single<Diary> {
        return Single<Diary>.create { single in
            NetworkManager.shared.requestModel(
                type: Diary.self,
                router: AlamofireRouter.diary(diaryId: diaryId),
                single: single
            )
            
            return Disposables.create()
        }
    }
    
    func updateDiary(content: Content, diaryId: Int) -> Single<Diary> {
        return Single<Diary>.create { single in
            NetworkManager.shared.requestModel(
                type: Diary.self,
                router: AlamofireRouter.updateDiary(diaryId: diaryId, content: content),
                single: single
            )
            
            return Disposables.create()
        }
    }
    
    func deleteDiary(diaryId: Int) -> Single<Bool> {
        return Single<Bool>.create { single in
            NetworkManager.shared.requestEmptyResponse(
                router: AlamofireRouter.deleteDiary(diaryId: diaryId),
                single: single
            )
            
            return Disposables.create()
        }
    }
    
}
