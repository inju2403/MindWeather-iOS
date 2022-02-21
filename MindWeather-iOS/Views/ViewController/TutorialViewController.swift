//
//  SubViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/15.
//

import UIKit

import FSPagerView

class TutorialViewController : UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    
    fileprivate let tutorialImages = ["1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "final.png"]
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            // 페이저뷰에 셀 등록
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            // 아이템 크기 설정
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.tutorialImages.count
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        
        pageControl.setFillColor(UIColor(rgb: K.mainColor), for: .normal)
        pageControl.setFillColor(UIColor(rgb: K.brownColor), for: .selected)
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return tutorialImages.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.image = UIImage(named: self.tutorialImages[index])
        cell.imageView?.contentMode = .scaleAspectFit
        
        // 그림자 제거
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
        
        if self.pageControl.currentPage < self.tutorialImages.count - 1 {
            nextButton.setTitle("다음", for: .normal)
        } else {
            nextButton.setTitle("시작", for: .normal)
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }

    @IBAction func skipButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "moveLoginIdentifier", sender: self)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if self.pageControl.currentPage < self.tutorialImages.count - 2 {
            nextButton.setTitle("다음", for: .normal)
        } else {
            nextButton.setTitle("시작", for: .normal)
        }
        
        if self.pageControl.currentPage == self.tutorialImages.count - 1 {
            self.performSegue(withIdentifier: "moveLoginIdentifier", sender: self)
        } else {
            self.pageControl.currentPage = self.pageControl.currentPage + 1
            self.pagerView.scrollToItem(at: self.pageControl.currentPage, animated: true)
        }
    }
    
}
