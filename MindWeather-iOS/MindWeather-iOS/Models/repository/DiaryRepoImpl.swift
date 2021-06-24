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
    
}
