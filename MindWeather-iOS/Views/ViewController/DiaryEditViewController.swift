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
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var yearText: UILabel!
    @IBOutlet weak var explainText: UILabel!
    @IBOutlet weak var loadingUI: UIActivityIndicatorView!
    @IBOutlet weak var loadingText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        if diaryId != K.newDiaryValue {
            dateText.isHidden = true
            content.isHidden = true
            yearText.isHidden = true
            explainText.isHidden = true
            
            loadingUI.isHidden = false
            loadingUI.startAnimating()
            loadingText.isHidden = true
            diaryDetailViewModel.loadDiary(diaryId: diaryId)
        } else {
            diaryDetailViewModel.newStateDiary()
            
            loadingUI.isHidden = true
            loadingUI.stopAnimating()
            loadingText.isHidden = true
        }
    }
    
    private func bindViewModel() {
        diaryDetailViewModel.content
            .bind(to: content.rx.text)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.date
            .bind(to: dateText.rx.text)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.year
            .bind(to: yearText.rx.text)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.receiver
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { value in
                    if value == "addOrUpdateDiary" {
                        //일기 작성 or 수정 후 dismiss
                        
                        self.dateText.isHidden = false
                        self.content.isHidden = false
                        self.yearText.isHidden = false
                        self.explainText.isHidden = false
                        
                        self.loadingUI.isHidden = true
                        self.loadingUI.stopAnimating()
                        self.loadingText.isHidden = true
                        
                        self.dismiss(animated: true, completion: nil)
                    } else if value == "loadDiary" {
                        
                        //로딩 ui 끄기
                        self.dateText.isHidden = false
                        self.content.isHidden = false
                        self.yearText.isHidden = false
                        self.explainText.isHidden = false
                        self.setUI()
                        
                        self.loadingUI.isHidden = true
                        self.loadingUI.stopAnimating()
                        self.loadingText.isHidden = true
                    } else if value == "newStateDiary" {
                        self.content.text = " "
                        self.setUI()
                        self.content.text = ""
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
        
        //로딩 ui 켜기
        loadingUI.isHidden = false
        loadingUI.startAnimating()
        loadingText.isHidden = false
        
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
    
    private func setUI() {
        let attrString = NSMutableAttributedString(string: content.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        content.attributedText = attrString
        content.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 15)
        content.textColor = UIColor(rgb: K.brownColor)
        content.textAlignment = .center
    }
}
