//
//  EmotionViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/29.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import Charts

class EmotionViewController : UIViewController {
    
    @IBOutlet weak var emotionGraph: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
