//
//  DiaryService.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/22.
//

import Foundation

import RxSwift

protocol DiaryService {
    func diarys() -> Single<[Diary]>
    func diary(diaryId: Int) -> Single<Diary>
    func updateDiary(content: Content, diaryId: Int) -> Single<Bool>
    func deleteDiary(diaryId: Int) -> Single<Bool>
    
    func emotions() -> Single<[Emotion]>
}
