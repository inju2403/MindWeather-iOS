//
//  DiaryDetailViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/27.
//

import UIKit
import RxSwift
import RxCocoa

class DiaryDetailViewController : UIViewController {
    
    var diaryId = 0
    
    override func viewDidLoad() {
        print(diaryId)
        
        setUI()
    }
    
    private func setUI() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
