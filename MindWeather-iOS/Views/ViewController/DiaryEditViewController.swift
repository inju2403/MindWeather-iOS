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
    
    var diaryId = K.newDiaryValue
    
    let diaryDetailViewModel = DiaryDetailViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var dayText: UILabel!
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        if diaryId != K.newDiaryValue {
            diaryDetailViewModel.loadDiary(diaryId: diaryId)
        }
    }
    
    private func bindViewModel() {
        diaryDetailViewModel.receiver
            .do(
                onSubscribe: {
                    //로딩 ui 켜기
                })
            .subscribe(
                onNext: { value in
                    if value == "addOrUpdateDiary" {
                        self.dismiss(animated: true, completion: nil)
                    } else {
//                        self.dateText.text = self.diaryDetailViewModel.date.value
//                        self.dayText.text = self.diaryDetailViewModel.dayOfTheWeek.value
                        self.content.text = self.diaryDetailViewModel.content.value
                        
                        //로딩 ui 끄기
                    }
                })
            .disposed(by: disposeBag)
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
    
    // 사용자가 바로 입력할 수 있도록 세팅
    override func viewWillAppear(_ animated: Bool) {
        self.content.becomeFirstResponder()
    }
    
    // 키보드 밖을 클릭하면 키보드가 내려가도록 세팅
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.content.resignFirstResponder()
    }
    
}
