//
//  WeatherDescriptionViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/02.
//

import UIKit

class WeatherDescriptionViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
