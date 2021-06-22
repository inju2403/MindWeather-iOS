//
//  IDiaryRepository.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation

protocol DiaryRepoType {
    func getDiarys() -> [Diary]
    func getDiaryById(diaryId: String) -> Diary
    func updateDiary(content: Content, diaryId: String)
    func deleteDiary(diaryId: String)
}
