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
    var emotions: BehaviorRelay<[Emotion]> { get }
    
    var receiver: PublishSubject<String> { get set }
    func getEmotions()
}

class EmotionViewModel: EmotionViewModelType {
    
    var disposeBag = DisposeBag()
    private let service = DiaryServiceImpl()
    
    var emotions: BehaviorRelay<[Emotion]> = BehaviorRelay(value: [])
    
    var receiver: PublishSubject<String> = PublishSubject<String>()
    
    func getEmotions() {
        _ = service.getEmotions()
            .subscribe { event in
                switch event {
                case .success(let emotions):
                    self.emotions.accept(emotions)
                    break
                case .failure(let error):
                    print("Error: ", error)
                    break
                }
                
            }
            .disposed(by: disposeBag)
    }
}

