//
//  DiaryDetailViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/27.
//

import UIKit
import RxSwift
import RxCocoa

class DiaryDetailViewController : UIViewController {
    
    var diaryId = 0
    
    let diaryDetailViewModel = DiaryDetailViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var yearText: UILabel!
    @IBOutlet weak var loadingUI: UIActivityIndicatorView!
    @IBOutlet weak var loadingText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindViewModel()
        diaryDetailViewModel.loadDiary(diaryId: diaryId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        diaryDetailViewModel.loadDiary(diaryId: diaryId)
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.diaryEditSegue, sender: self)
    }
    
    @IBAction func delteButtonClicked(_ sender: UIButton) {
        showAlert(style: .actionSheet, message: "일기를 삭제하시겠어요?")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DiaryEditViewController
        destinationVC.diaryId = diaryId
    }
    
    private func bindViewModel() {
        diaryDetailViewModel.date
            .asDriver()
            .drive(dateText.rx.text)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.content
            .asDriver()
            .drive(content.rx.text)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.year
            .asDriver()
            .drive(yearText.rx.text)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.weatherImage
            .asDriver()
            .drive(weatherImage.rx.image)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.weatherImageDescription
            .asDriver()
            .drive(weatherDescription.rx.text)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.receiver
            .observe(on: MainScheduler.instance)
            .do(
                onSubscribe: {
                    //로딩 ui 켜기
                    self.dateText.isHidden = true
                    self.content.isHidden = true
                    self.weatherImage.isHidden = true
                    self.weatherDescription.isHidden = true
                    self.yearText.isHidden = true
                    
                    self.loadingUI.isHidden = false
                    self.loadingUI.startAnimating()
                    self.loadingText.isHidden = false
                })
            .subscribe(
                onNext: { value in
                    if value == "deleteDiary" {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    //로딩 ui 끄기
                    self.loadingUI.isHidden = true
                    self.loadingUI.stopAnimating()
                    self.loadingText.isHidden = true
                    
                    self.dateText.isHidden = false
                    self.content.isHidden = false
                    self.weatherImage.isHidden = false
                    self.weatherDescription.isHidden = false
                    self.yearText.isHidden = false
                })
            .disposed(by: disposeBag)
    }
    
    private func setUI() {
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let attrString = NSMutableAttributedString(string: content.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        content.attributedText = attrString
        
        content.textAlignment = .center
    }
    
    func showAlert(style: UIAlertController.Style, message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: style)
        let success = UIAlertAction(title: "확인", style: .default, handler: {_ in
            self.diaryDetailViewModel.deleteDiary(diaryId: self.diaryId)
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
