//
//  MainTabBarController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class MyTabBarViewController: UITabBarController {
    
    var disposeBag = DisposeBag()
    let service = DiaryRepoImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = service.getDiarys()
            .subscribe({_ in print("ok")})
            .disposed(by: disposeBag)
    }
}

