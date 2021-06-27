//
//  DiaryListController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/26.
//

import UIKit
import RxSwift
import RxCocoa

class DiaryListController : UIViewController {
    
    @IBOutlet weak var diaryListTableView: UITableView!
    
    let diaryListViewModel = DiaryListViewModel()
    let disposeBag = DisposeBag()
    
    var diaryList: [String] = []
    var diaryListSize: Int = 0
    
    override func viewDidLoad() {
//        diaryListViewModel.testContent
//            .bind(to: testLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        diaryListViewModel.diaryList
//            .bind(to: diaryList)
//            .disposed(by: disposeBag)
        
        diaryListTableView.register(UINib(nibName: K.diaryCellNibName, bundle: nil), forCellReuseIdentifier: K.diaryListCellIdentifier)
        
        bindTableView()
        diaryListViewModel.getDiarys()
    }
    
    private func bindTableView() {
        diaryListViewModel.diaryList
            .bind(to: diaryListTableView.rx.items(cellIdentifier: K.diaryListCellIdentifier, cellType: DiaryListCell.self)) { (index: Int, element: Diary, cell: DiaryListCell) in
                cell.summaryView?.text = element.content
                cell.dateView?.text = element.updated_at
            }.disposed(by: disposeBag)
    }

}

extension DiaryListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryListSize
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.diaryListCellIdentifier, for: indexPath)
//        cell.textLabel?.text =
        return cell
    }

}
