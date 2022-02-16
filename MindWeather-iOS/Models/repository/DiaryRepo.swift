//
//  DiaryRepo.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import Foundation
import RxSwift

protocol DiaryRepo {
    func getDiarys() -> Single<[Diary]>
    func getDiaryById(diaryId: Int) -> Single<Diary>
    func updateDiary(content: Content, diaryId: Int) -> Single<Bool>
    func deleteDiary(diaryId: Int) -> Single<Bool>
}
