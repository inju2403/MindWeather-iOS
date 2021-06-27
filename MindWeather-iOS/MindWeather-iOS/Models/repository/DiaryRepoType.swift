//
//  IDiaryRepository.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation
import RxSwift

protocol DiaryRepoType {
    func getDiarys() -> Single<[Diary]>
    func getDiaryById(diaryId: Int) -> Single<Diary>
//    func updateDiary(content: Content, diaryId: String)
//    func deleteDiary(diaryId: String)
}
