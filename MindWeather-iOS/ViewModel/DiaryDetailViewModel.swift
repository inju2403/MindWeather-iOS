//
//  DiaryDetailViewModel.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/26.
//

import Foundation

import RxRelay
import RxSwift

protocol DiaryDetailViewModelType {
    var date: BehaviorRelay<String> { get set }
    var emotion: BehaviorRelay<String> { get set }
    var content: BehaviorRelay<String> { get set }
    var year: BehaviorRelay<String> { get set }
    var weatherImage: BehaviorRelay<UIImage> { get set }
    var weatherImageDescription: BehaviorRelay<String> { get set }
    
    var receiver: PublishSubject<String> { get set }
    
    func diary(diaryId: Int)
    func addOrUpdateDiary(content: Content, diaryId: Int)
    func deleteDiary(diaryId: Int)
    func newStateDiary()
}

class DiaryDetailViewModel: DiaryDetailViewModelType {
    
    var disposeBag = DisposeBag()
    private let service: DiaryService
    
    var date: BehaviorRelay<String> = BehaviorRelay(value: "date")
    var emotion: BehaviorRelay<String> = BehaviorRelay(value: "emotion")
    var content: BehaviorRelay<String> = BehaviorRelay(value: "")
    var year: BehaviorRelay<String> = BehaviorRelay(value: "year")
    var weatherImage: BehaviorRelay<UIImage> = BehaviorRelay(value: UIImage(named: "ic_happiness")!)
    var weatherImageDescription: BehaviorRelay<String> = BehaviorRelay(value: "행복을 느낀 하루")
    
    var receiver: PublishSubject<String> = PublishSubject<String>()

    init(service: DiaryService) {
        self.service = service
    }

    func diary(diaryId: Int) {
        service.diary(diaryId: diaryId)
            .subscribe { [weak self] event in
                switch event {
                case .success(let diary):
                    self?.content.accept(diary.content ?? "")
                    self?.receiver.onNext(Constant.receiver.diary)

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

                    let updatedAt = diary.updated_at!
                    if let index = updatedAt.firstIndex(of: "T") {
                        let substring = updatedAt[..<index]
                        let time = String(substring)
                        let date: Date = dateFormatter.date(from: time)!

                        dateFormatter.dateFormat = "MMdd  eee"
                        self?.date.accept(dateFormatter.string(from: date))

                        dateFormatter.dateFormat = "''yy"
                        self?.year.accept(dateFormatter.string(from: date))
                    }


                    var emotions = [diary.happiness!, diary.anger!, diary.sadness!, diary.worry!, diary.neutrality!]

                    emotions = emotions.sorted(by: >)

                    if emotions[0] == emotions[1] {
                        let image = UIImage(named: "ic_unknowability")!
                        self?.weatherImage.accept(image)
                        self?.weatherImageDescription.accept("복합적인 감정의 하루")
                    } else if emotions[0] == diary.happiness {
                        let image = UIImage(named: "ic_happiness")!
                        self?.weatherImage.accept(image)
                        self?.weatherImageDescription.accept("행복을 느낀 하루")
                    } else if emotions[0] == diary.anger {
                        let image = UIImage(named: "ic_anger")!
                        self?.weatherImage.accept(image)
                        self?.weatherImageDescription.accept("화가 났던 하루")
                    } else if emotions[0] == diary.sadness {
                        let image = UIImage(named: "ic_sadness")!
                        self?.weatherImage.accept(image)
                        self?.weatherImageDescription.accept("슬픔을 느낀 하루")
                    } else if emotions[0] == diary.worry {
                        let image = UIImage(named: "ic_worry")!
                        self?.weatherImage.accept(image)
                        self?.weatherImageDescription.accept("걱정을 느낀 하루")
                    } else if emotions[0] == diary.neutrality {
                        let image = UIImage(named: "ic_neutrality")!
                        self?.weatherImage.accept(image)
                        self?.weatherImageDescription.accept("감정이 중립인 하루")
                    }
                    break
                case .failure(let error):
                    print("Error: ", error)
                    break
                }

            }
            .disposed(by: disposeBag)
    }

    func addOrUpdateDiary(content: Content, diaryId: Int) {
        service.updateDiary(content: content, diaryId: diaryId)
            .subscribe { [weak self] event in
                switch event {
                case .success(_):
                    self?.receiver.onNext(Constant.receiver.addOrUpdateDiary)
                    break
                case .failure(let error):
                    print("Error: ", error)
                    break
                }
            }
    }
    
    func deleteDiary(diaryId: Int) {
        service.deleteDiary(diaryId: diaryId)
            .subscribe { [weak self] event in
                switch event {
                case .success(_):
                    self?.receiver.onNext(Constant.receiver.deleteDiary)
                    break
                case .failure(let error):
                    print("Error: ", error)
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    func newStateDiary() {
        self.receiver.onNext(Constant.receiver.newStateDiary)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd  eee"
        self.date.accept(dateFormatter.string(from: Date()))
        
        dateFormatter.dateFormat = "''yy"
        self.year.accept(dateFormatter.string(from: Date()))
    }
}
