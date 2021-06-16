//
//  SubViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/15.
//

import UIKit

class TutorialViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 임시로 2초 세팅
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "moveLoginIdentifier", sender: self)
        }
    }


}
