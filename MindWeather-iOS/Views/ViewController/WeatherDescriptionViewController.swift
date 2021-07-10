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

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
