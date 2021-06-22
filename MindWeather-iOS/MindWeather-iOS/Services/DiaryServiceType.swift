//
//  DiaryServiceType.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/22.
//

import Foundation

protocol DiaryServiceType {
    func getDiarys() -> [Diary]
    func getDiaryById(diaryId: String) -> Diary
    func updateDiary(content: Content, diaryId: String)
    func deleteDiary(diaryId: String)
    
    func getEmotions() -> [Emotion]
}
