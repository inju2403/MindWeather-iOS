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
}
