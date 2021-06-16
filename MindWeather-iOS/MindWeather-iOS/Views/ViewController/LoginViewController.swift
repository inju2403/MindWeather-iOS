//
//  LoginViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/16.
//

import Foundation

import UIKit

class LoginViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UserDefaults.standard.set("false", forKey: "runFirst") // 최초 실행시 설정
    }


}
