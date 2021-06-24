//
//  DiaryServiceImpl.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/22.
//

import Foundation
import RxSwift

class DiaryServiceImpl: DiaryServiceType {
    func getDiarys() -> Single<[Diary]> {
        <#code#>
    }
    
    func getDiaryById(diaryId: String) -> Single<Diary> {
        <#code#>
    }
    
    func updateDiary(content: Content, diaryId: String) {
        <#code#>
    }
    
    func deleteDiary(diaryId: String) {
        <#code#>
    }
    
    func getEmotions() -> [Emotion] {
        <#code#>
    }
    
    
}
