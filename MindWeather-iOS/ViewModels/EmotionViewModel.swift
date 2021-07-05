//
//  EmotionViewModel.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/05.
//

import Foundation
import RxSwift
import RxRelay

protocol EmotionViewModelType {
    var aWeekEmotion: BehaviorRelay<Emotion> { get set }
    var aMonthEmotion: BehaviorRelay<Emotion> { get set }
    var sixMonthEmotion: BehaviorRelay<Emotion> { get set }
    var aYearEmotion: BehaviorRelay<Emotion> { get set }
    
    var receiver: PublishSubject<String> { get set }
    func getEmotions()
}

class EmotionViewModel: EmotionViewModelType {
    
    var disposeBag = DisposeBag()
    private let service = DiaryServiceImpl()
    
    var aWeekEmotion: BehaviorRelay<Emotion> = BehaviorRelay(value: Emotion())
    var aMonthEmotion: BehaviorRelay<Emotion> = BehaviorRelay(value: Emotion())
    var sixMonthEmotion: BehaviorRelay<Emotion> = BehaviorRelay(value: Emotion())
    var aYearEmotion: BehaviorRelay<Emotion> = BehaviorRelay(value: Emotion())
    
    var receiver: PublishSubject<String> = PublishSubject<String>()
    
    func getEmotions() {
        _ = service.getEmotions()
            .subscribe { event in
                switch event {
                case .success(let emotions):
                    self.aWeekEmotion.accept(emotions[0])
                    self.aMonthEmotion.accept(emotions[1])
                    self.sixMonthEmotion.accept(emotions[2])
                    self.aYearEmotion.accept(emotions[3])
                    
                    self.receiver.onNext("getEmotions")
                    break
                case .failure(let error):
                    print("Error: ", error)
                    break
                }
                
            }
            .disposed(by: disposeBag)
    }
}

