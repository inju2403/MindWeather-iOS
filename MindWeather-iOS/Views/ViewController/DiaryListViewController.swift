//
//  DiaryListController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/26.
//

import UIKit
import RxSwift
import RxCocoa

class DiaryListViewController : UIViewController {
    
    @IBOutlet weak var diaryListTableView: UITableView!
    @IBOutlet weak var loadingUI: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateText: UILabel!
    
    let diaryListViewModel = DiaryListViewModel()
    let disposeBag = DisposeBag()
    
    var diaryListIsUpdated: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var diaryList: [String] = []
    var diaryListSize: Int = 0
    
    var selectedDiaryId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 일기 리스트에 대한 노티피케이션 추가 - 일기 추가, 일기 수정, 일기 삭제에서 사용
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(isUpdateDiarys),
            name: Notification.Name(rawValue: K.isUpdateDiarysNotificationName),
            object:  nil
        )
        
        diaryListTableView.register(
            UINib(nibName: K.diaryCellNibName, bundle: nil),
            forCellReuseIdentifier: K.diaryListCellIdentifier
        )
        
        bindTableView()
        diaryListViewModel.getDiarys()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc private func isUpdateDiarys() {
        diaryListViewModel.getDiarys()
    }
    
    private func bindTableView() {
        diaryListViewModel.receiver
            .observe(on: MainScheduler.instance)
            .do(
                onSubscribe: { [weak self] in
                    guard let self = self else { return }
                    //로딩 ui 켜기
                    self.loadingUI.startAnimating()
                })
            .subscribe(
                onNext: { [weak self] value in
                    guard let self = self else { return }
                    if value == "getDiarys" {
                        //로딩 ui 끄기
                        self.loadingUI.stopAnimating()
                    }
                })
            .disposed(by: disposeBag)
        
        diaryListIsUpdated
            .subscribe(
                onNext: { [weak self] value in
                    guard let self = self else { return }
                    self.diaryListViewModel.getDiarys()
                })
            .disposed(by: disposeBag)
        
        diaryListViewModel.diaryItemCnt
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] value in
                    guard let self = self else { return }
                    if value == 0 {
                        // 일기 리스트 사이즈가 0이면 문구 노출
                        self.emptyStateText.isHidden = false
                    } else {
                        self.emptyStateText.isHidden = true
                    }
                })
            .disposed(by: disposeBag)
        
        
        diaryListViewModel.diaryList
            .asDriver()
            .drive(diaryListTableView.rx.items(cellIdentifier: K.diaryListCellIdentifier, cellType: DiaryListCell.self)) {
                [weak self] (index: Int, element: Diary, cell: DiaryListCell) in
                cell.summaryView?.text = element.content
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                
                let updatedAt = element.updated_at!
                if let index = updatedAt.firstIndex(of: "T") {
                    let substring = updatedAt[..<index]
                    let time = String(substring)
                    let date: Date = dateFormatter.date(from: time)!
                    
                    dateFormatter.dateFormat = "''yy  MMdd  eee"
                    
                    cell.dateText?.text = dateFormatter.string(from: date)
                }
                
                var emotions = [element.happiness!, element.anger!, element.sadness!, element.worry!, element.neutrality!]
                
                emotions = emotions.sorted(by: >)
                if emotions[0] == emotions[1] {
                    let image = UIImage(named: "ic_unknowability")
                    cell.diaryCardImage.image = image
                } else if emotions[0] == element.happiness {
                    let image = UIImage(named: "ic_happiness")
                    cell.diaryCardImage.image = image
                } else if emotions[0] == element.anger {
                    let image = UIImage(named: "ic_anger")
                    cell.diaryCardImage.image = image
                } else if emotions[0] == element.sadness {
                    let image = UIImage(named: "ic_sadness")
                    cell.diaryCardImage.image = image
                } else if emotions[0] == element.worry {
                    let image = UIImage(named: "ic_worry")
                    cell.diaryCardImage.image = image
                } else if emotions[0] == element.neutrality{
                    let image = UIImage(named: "ic_neutrality")
                    cell.diaryCardImage.image = image
                }
            }.disposed(by: disposeBag)
        
        //일기 아이템 클릭시 보낼 일기 아이디 저장
        diaryListTableView.rx.modelSelected(Diary.self)
                    .subscribe(onNext: { [weak self] diary in
                        guard let self = self else { return }
                        self.selectedDiaryId = diary.id ?? 0
                    }).disposed(by: disposeBag)
        
        //일기 아이템 클릭시 일기 상세화면으로 이동
        diaryListTableView.rx.itemSelected
                    .subscribe(onNext: { [weak self] indexPath in
                        guard let self = self else { return }
                        self.performSegue(withIdentifier: K.diaryDetailSegue, sender: self)
                    }).disposed(by: disposeBag)
        
        //테이블뷰에 애니메이션 추가
        diaryListTableView.rx.willDisplayCell
                    .subscribe(onNext: { [weak self] cell, indexPath in
                            cell.alpha = 0
                            UIView.animate(withDuration: 0.15) {
                                cell.alpha = 1.0
                            }
                       })
                    .disposed(by: disposeBag)
    }

}

extension DiaryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryListSize
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.diaryListCellIdentifier, for: indexPath)
        return cell
    }
}

extension DiaryListViewController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DiaryDetailViewController
        guard diaryListTableView.indexPathForSelectedRow != nil else { return }
        destinationVC.diaryId = selectedDiaryId
    }
    
}
