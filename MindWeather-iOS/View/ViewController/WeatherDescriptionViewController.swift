//
//  WeatherDescriptionViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/07/02.
//

import UIKit

class WeatherDescriptionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        anywhereAllowsBackSwipeGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 네비게이션 컨트롤러 루트에서만 스와이프가 안먹히게 함
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (self.navigationController?.viewControllers.count)! > 1
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func anywhereAllowsBackSwipeGesture() {
        // 네비게이션 컨트롤러 화면의 왼쪽 모서리 이외의 부분에서도 Back Swipe Gesture가 작동할 수 있도록 함
        let popGestureRecognizer = self.navigationController!.interactivePopGestureRecognizer!
        if let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
            let gestureRecognizer = UIPanGestureRecognizer()
            gestureRecognizer.setValue(targets, forKey: "targets")
            self.view.addGestureRecognizer(gestureRecognizer)
        }
    }
}
