//
//  PersonalInformationProcessingViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/17.
//

import UIKit

class PersonalInformationProcessingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 네비게이션 컨트롤러 루트에서만 스와이프가 안먹히게 함
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (self.navigationController?.viewControllers.count)! > 1
    }
}
