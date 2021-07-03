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
    
    func getDiarys()
}

class DiaryListViewModel: DiaryListViewModelType {
    
    var disposeBag = DisposeBag()
    private let service = DiaryServiceImpl()
    
    var diaryList: BehaviorRelay<[Diary]> = BehaviorRelay(value: [])
    var diaryItemCnt = BehaviorRelay(value: 0)
    
    func getDiarys() {
        _ = service.getDiarys()
            .subscribe { event in
                switch event {
                case .success(let diarys):
                    self.diaryList.accept(diarys)
                    self.diaryItemCnt.accept(diarys.count)
                case .failure(let error):
                    print("Error: ", error)
                }
                
            }
            .disposed(by: disposeBag)
    }
}
