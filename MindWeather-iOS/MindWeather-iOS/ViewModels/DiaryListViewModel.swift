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
    
    func getDiarys() {
        _ = service.getDiarys()
            .subscribe { event in
                switch event {
                case .success(let diarys):
                    self.testContent.accept(diarys[0].content ?? "")
                case .failure(let error):
                    print("Error: ", error)
                }
                
            }
            .disposed(by: disposeBag)
    }
}
