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
    
    var diaryList: [String] = []
    var diaryListSize: Int = 0
    
    var selectedDiaryId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diaryListTableView.register(UINib(nibName: K.diaryCellNibName, bundle: nil), forCellReuseIdentifier: K.diaryListCellIdentifier)
        
        setUI()
        bindTableView()
        diaryListViewModel.getDiarys()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.emptyStateText.isHidden = true
    }
    
    private func setUI() {
        // 네비게이션 바 숨김
        self.navigationController?.isNavigationBarHidden = true
        // 네비게이션 바를 숨기면서 스와이프 동작이 가능하게 함
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func bindTableView() {
        diaryListViewModel.receiver
            .observe(on: MainScheduler.instance)
            .do(
                onSubscribe: {
                    //로딩 ui 켜기
                    self.loadingUI.isHidden = false
                    self.loadingUI.startAnimating()
                })
            .subscribe(
                onNext: { value in
                    if value == "getDiarys" {
                        //로딩 ui 끄기
                        self.loadingUI.isHidden = true
                        self.loadingUI.stopAnimating()
                        self.animateTable(tblVW: self.diaryListTableView)
                    }
                })
            .disposed(by: disposeBag)
        
        diaryListViewModel.diaryItemCnt
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { value in
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
            .drive(diaryListTableView.rx.items(cellIdentifier: K.diaryListCellIdentifier, cellType: DiaryListCell.self)) { (index: Int, element: Diary, cell: DiaryListCell) in
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
    }
    
    func animateTable(tblVW: UITableView) {
        tblVW.reloadData()
        let cells = tblVW.visibleCells
        let tableHeight: CGFloat = tblVW.bounds.size.height
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var index = 0
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1, delay: 0.01 * Double(index), options: .allowAnimatedContent, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            index += 1
        }
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
