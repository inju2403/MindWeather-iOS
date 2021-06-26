//
//  DiaryListController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/26.
//

import UIKit
import RxSwift
import RxCocoa

class DiaryListController : UIViewController {
    
    let diaryListViewModel = DiaryListViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        diaryListViewModel.testContent
            .bind(to: testLabel.rx.text)
            .disposed(by: disposeBag)
        
        diaryListViewModel.getDiarys()
    }
}
