//
//  DiaryListViewModel.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/26.
//

import Foundation
import RxSwift
import RxRelay

protocol DiaryListViewModelType {
    var diaryList: BehaviorRelay<[Diary]> { get }
    var diaryItemCnt: BehaviorRelay<Int> { get set }
    
    var receiver: PublishSubject<String> { get set }
    
    func diarys()
}

class DiaryListViewModel: DiaryListViewModelType {
    
    var disposeBag = DisposeBag()
    private let service = DiaryServiceImpl()
    
    var diaryList: BehaviorRelay<[Diary]> = BehaviorRelay(value: [])
    var diaryItemCnt = BehaviorRelay(value: -1)
    
    var receiver: PublishSubject<String> = PublishSubject<String>()
    
    func diarys() {
        service.diarys()
            .subscribe { [weak self] event in
                switch event {
                case .success(let diarys):
                    self?.diaryList.accept(diarys)
                    self?.diaryItemCnt.accept(diarys.count)
                    self?.receiver.onNext("diarys")
                    break
                case .failure(let error):
                    print("Error: ", error)
                    break
                }
                
            }
            .disposed(by: disposeBag)
    }
}
