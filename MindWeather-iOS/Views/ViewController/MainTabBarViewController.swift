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
        
        // 네비게이션 바 숨김
        self.navigationController?.isNavigationBarHidden = true
        // 네비게이션 바를 숨기면서 스와이프 동작이 가능하게 함
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: EditClickViewController.self) {
            self.performSegue(withIdentifier: K.diaryEditSegue, sender: self)
            return false
        }
        return true
    }
}
