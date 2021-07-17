//
//  MainTabBarController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var disposeBag = DisposeBag()
    let service = DiaryRepoImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        _ = service.getDiarys()
            .subscribe { event in
                switch event {
                case .success(let diarys):
                    print("diarys: ", diarys)
                case .failure(let error):
                    print("Error: ", error)
                }
                
            }
            .disposed(by: disposeBag)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: EditClickViewController.self) {
            self.performSegue(withIdentifier: K.diaryEditSegue, sender: self)
            return false
        }
        return true
    }
}
