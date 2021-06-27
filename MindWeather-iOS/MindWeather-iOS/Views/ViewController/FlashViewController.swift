//
//  ViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/15.
//
import UIKit

class FlashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let runFirst = UserDefaults.standard.value(forKey: "runFirst")
        let token = UserDefaults.standard.value(forKey: "token")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if token != nil { //자동 로그인
                self.performSegue(withIdentifier: "moveMainTabBarIdentifier", sender: self)
            } else if runFirst == nil {
                self.performSegue(withIdentifier: "moveTutorialIdentifier", sender: self)
            } else {
                self.performSegue(withIdentifier: "moveLoginIdentifier", sender: self)
            }
        }
    }
    
}

