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
        
        let diaryListIcon = UITabBarItem(title: nil, image: UIImage(named: "text.book.closed"), selectedImage: UIImage(named: "text.book.closed"))
        let emotionIcon = UITabBarItem(title: nil, image: UIImage(named: "calendar"), selectedImage: UIImage(named: "calendar"))
        
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
}

//extension MainTabBarViewController: UITabBarControllerDelegate {
//    let diaryListVC = DiaryListViewController()
//    let emotionVC = EmotionViewController()
//}

