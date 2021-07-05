//
//  EmotionViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/29.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import Charts

class EmotionViewController : UIViewController {
    
    let emotionViewModel = EmotionViewModel()
    let disposeBag = DisposeBag()
    
    var aWeekEmotion = Emotion()
    var aMonthEmotion = Emotion()
    var sixMonthEmotion = Emotion()
    var aYearEmotion = Emotion()
    
    let emotionNames = ["행복", "중립", "걱정", "슬픔", "분노"]
    
    var mainColor = 0xFDF5E6 // 메인 색상
    var brownColor = 0x8B4513 // 텍스트 색상

    var goldColor = 0xFFA700 // 행복
    var greyColor = 0xBBBBBB // 중립
    var pupleColor = 0xA575CD // 걱정
    var blueColor = 0x42A5F5 // 슬픔
    var redColor = 0xFF4950 // 분노

    @IBOutlet weak var aYearButton: UIButton!
    @IBOutlet weak var sixMonthButton: UIButton!
    @IBOutlet weak var aMonthButton: UIButton!
    @IBOutlet weak var aWeekButton: UIButton!
    
    @IBOutlet weak var emotionGraph: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emotionViewModel.aWeekEmotion
            .subscribe(
                onNext: { value in
                    self.aWeekEmotion = value
            })
            .disposed(by: disposeBag)
        
        emotionViewModel.aMonthEmotion
            .subscribe(
                onNext: { value in
                    self.aMonthEmotion = value
            })
            .disposed(by: disposeBag)
        
        emotionViewModel.sixMonthEmotion
            .subscribe(
                onNext: { value in
                    self.sixMonthEmotion = value
            })
            .disposed(by: disposeBag)
        
        emotionViewModel.aYearEmotion
            .subscribe(
                onNext: { value in
                    self.aYearEmotion = value
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        makeChartaYear()
    }
    
    @IBAction func aYearButtonPressed(_ sender: UIButton) {
        makeChartaYear()
    }
    
    @IBAction func sixMonthButtonPressed(_ sender: UIButton) {
        makeChartSixMonth()
    }
    
    @IBAction func aMonthButtonPressed(_ sender: UIButton) {
        makeChartaMonth()
    }
    
    @IBAction func aWeekButtonPressed(_ sender: UIButton) {
        makeChartaWeek()
    }
    
    private func makeChartaYear() {
        // 1년의 감정
        
        // 폰트 설정
        aYearButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        sixMonthButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        aMonthButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        aWeekButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        // 텍스트 컬러 설정
        aYearButton.setTitleColor(UIColor(rgb: brownColor), for: .normal)
        sixMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aWeekButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        let goals = [36, 8, 26, 13, 18, 10]
        
        customizeChart(dataPoints: emotionNames, values: goals.map{ Double($0) }, title: "1년의 감정")
    }
    
    private func makeChartSixMonth() {
        // 6개월의 감정
        
        // 폰트 설정
        aYearButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        sixMonthButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        aMonthButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        aWeekButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        // 텍스트 컬러 설정
        aYearButton.setTitleColor(UIColor.lightGray, for: .normal)
        sixMonthButton.setTitleColor(UIColor(rgb: brownColor), for: .normal)
        aMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aWeekButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        let goals = [36, 8, 26, 13, 18, 10]
        
        customizeChart(dataPoints: emotionNames, values: goals.map{ Double($0) }, title: "6개월의 감정")
    }
    
    private func makeChartaMonth() {
        // 한달의 감정
        
        // 폰트 설정
        aYearButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        sixMonthButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        aMonthButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        aWeekButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        // 텍스트 컬러 설정
        aYearButton.setTitleColor(UIColor.lightGray, for: .normal)
        sixMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aMonthButton.setTitleColor(UIColor(rgb: brownColor), for: .normal)
        aWeekButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        let goals = [36, 8, 26, 13, 18, 10]
        
        customizeChart(dataPoints: emotionNames, values: goals.map{ Double($0) }, title: "한달의 감정")
    }
    
    private func makeChartaWeek() {
        // 한주의 감정
        
        // 폰트 설정
        aYearButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        sixMonthButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        aMonthButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        aWeekButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        
        // 텍스트 컬러 설정
        aYearButton.setTitleColor(UIColor.lightGray, for: .normal)
        sixMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aWeekButton.setTitleColor(UIColor(rgb: brownColor), for: .normal)
        
        let goals = [36, 8, 26, 13, 18, 10]
        
        customizeChart(dataPoints: emotionNames, values: goals.map{ Double($0) }, title: "한주의 감정")
    }
    
    private func customizeChart(dataPoints: [String], values: [Double], title: String) {
      // TO-DO: customize the chart here
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
          dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
        emotionGraph.data = pieChartData
        
        // 가운데 빈 원형 부분 색상 설정
        emotionGraph.holeColor = UIColor(rgb: mainColor)
        
        // 센터 텍스트 속성 설정
        let myAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "ArialHebrew", size: 18)!,
            .foregroundColor: UIColor(rgb: brownColor)
        ]
        let myAttrString = NSAttributedString(string: title, attributes: myAttribute)
        emotionGraph.centerAttributedText = myAttrString
        emotionGraph.drawCenterTextEnabled = true
        
        // 엔트리 텍스트 속성 설정
        emotionGraph.entryLabelFont = UIFont(name: "ArialHebrew", size: 14)

        // 하단 텍스트 속성 설정
//        emotionGraph.legend.font = UIFont(name: "ArialHebrew", size: 12)!
        emotionGraph.legend.textColor = UIColor(rgb: brownColor)
        
        emotionGraph.animate(yAxisDuration: 1, easingOption: .easeInOutCubic)
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        let colors: [UIColor] = [UIColor(rgb: goldColor), UIColor(rgb: greyColor), UIColor(rgb: pupleColor), UIColor(rgb: blueColor), UIColor(rgb: redColor)]
        return colors
    }
}

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

    convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }
    // let's suppose alpha is the first component (ARGB)

    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}
