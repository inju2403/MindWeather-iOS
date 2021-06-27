//
//  DiaryServiceImpl.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/22.
//

import Foundation
import RxSwift

class DiaryServiceImpl: DiaryServiceType {
    
    let repo = DiaryRepoImpl()
    
    func getDiarys() -> Single<[Diary]> {
        return repo.getDiarys()
    }

    func getDiaryById(diaryId: Int) -> Single<Diary> {
        return repo.getDiaryById(diaryId: diaryId)
    }

//    func updateDiary(content: Content, diaryId: String) {
//        <#code#>
//    }
//
//    func deleteDiary(diaryId: String) {
//        <#code#>
//    }
//
//    func getEmotions() -> [Emotion] {
//        <#code#>
//    }
    
    
}
