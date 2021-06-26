//
//  DiaryListViewModel.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/26.
//

import Foundation
import RxSwift
import RxRelay

class DiaryListViewModel {
    
    var disposeBag = DisposeBag()
    private let service = DiaryServiceImpl()
    
    var testContent = BehaviorRelay(value: "content...")
    
    var diaryList = BehaviorRelay(value: [])
    var diaryItemCnt = BehaviorRelay(value: 0)
    
    func getDiarys() {
        _ = service.getDiarys()
            .subscribe { event in
                switch event {
                case .success(let diarys):
                    self.testContent.accept(diarys[0].content ?? "")
                    self.diaryList.accept(diarys)
                    self.diaryItemCnt.accept(diarys.count)
                case .failure(let error):
                    print("Error: ", error)
                }
                
            }
            .disposed(by: disposeBag)
    }
}
