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
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(diaryId)
        
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DiaryEditViewController
        destinationVC.diaryId = diaryId
    }
    
    private func bindViewModel() {
        diaryDetailViewModel.date
            .bind(to: date.rx.text)
            .disposed(by: disposeBag)
        
        diaryDetailViewModel.content
            .bind(to: content.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setUI() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
