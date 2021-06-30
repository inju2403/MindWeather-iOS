//
//  DiaryDetailViewModel.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/26.
//

import Foundation
import RxSwift
import RxRelay

protocol DiaryDetailViewModelType {
    var date: BehaviorRelay<String> { get set }
    var dayOfTheWeek: BehaviorRelay<String> { get set }
    var emotion: BehaviorRelay<String> { get set }
    var content: BehaviorRelay<String> { get set }
    var year: BehaviorRelay<String> { get set }
    
//    func loadDiary(diaryId: String)
//    func addOrUpdateDiary(diaryId: String)
//    func deleteDiary(diaryId: String)
}

class DiaryDetailViewModel: DiaryDetailViewModelType {
    
    var disposeBag = DisposeBag()
    private let service = DiaryServiceImpl()
    
    var date: BehaviorRelay<String> = BehaviorRelay(value: "date")
    var dayOfTheWeek: BehaviorRelay<String> = BehaviorRelay(value: "dayOfTheWeek")
    var emotion: BehaviorRelay<String> = BehaviorRelay(value: "emotion")
    var content: BehaviorRelay<String> = BehaviorRelay(value: "content")
    var year: BehaviorRelay<String> = BehaviorRelay(value: "year")
    
    var addOk: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func addOrUpdateDiary(content: Content, diaryId: Int) {
        _ = service.updateDiary(content: content, diaryId: diaryId)
            .subscribe { event in
                switch event {
                case .success(let value):
                    self.addOk.accept(value)
                    break
                case .failure(let error):
                    print("Error: ", error)
                    break
                }
            }
    }
    
    func deleteDiary() {
        //todo
    }
    
    func loadDiary(diaryId: Int) {
        _ = service.getDiaryById(diaryId: diaryId)
            .subscribe { event in
                switch event {
                case .success(let diary):
                    self.date.accept(diary.updated_at ?? "")
                    self.content.accept(diary.content ?? "")
                    break
                case .failure(let error):
                    print("Error: ", error)
                    break
                }
                
            }
            .disposed(by: disposeBag)
    }
    
    
}
