//
//  DiaryEditViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/29.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DiaryEditViewController : UIViewController {
    
    var diaryId = 987654321
    
    let diaryDetailViewModel = DiaryDetailViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var dayText: UILabel!
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let content = content.text else {
            return
        }
        
        let sendContent = Content(content: content)
        diaryDetailViewModel.addOrUpdateDiary(content: sendContent, diaryId: diaryId)
        
    }
}
