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
    
    func loadDiary()
    func addOrUpdateDiary()
    func deleteDiary()
}

class DiaryDetailViewModel: DiaryDetailViewModelType {
    var date: BehaviorRelay<String> = BehaviorRelay(value: "date")
    var dayOfTheWeek: BehaviorRelay<String> = BehaviorRelay(value: "dayOfTheWeek")
    var emotion: BehaviorRelay<String> = BehaviorRelay(value: "emotion")
    var content: BehaviorRelay<String> = BehaviorRelay(value: "content")
    var year: BehaviorRelay<String> = BehaviorRelay(value: "year")
    
    func addOrUpdateDiary() {
        //todo
    }
    
    func deleteDiary() {
        //todo
    }
    
    func loadDiary() {
        //todo
    }
    
    
}
