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
        
        bindTableView()
        diaryListViewModel.getDiarys()
    }
    
    private func bindTableView() {
        diaryListViewModel.diaryList
            .bind(to: diaryListTableView.rx.items(cellIdentifier: K.diaryListCellIdentifier)) { (index: Int, element: Diary, cell: UITableViewCell) in
                cell.textLabel?.text = element.content
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
