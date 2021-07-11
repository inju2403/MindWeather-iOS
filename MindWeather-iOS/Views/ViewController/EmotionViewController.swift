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
    
    var emotionNames: [String] = []
    var emotionsRate: [Double] = []

    @IBOutlet weak var aYearButton: UIButton!
    @IBOutlet weak var sixMonthButton: UIButton!
    @IBOutlet weak var aMonthButton: UIButton!
    @IBOutlet weak var aWeekButton: UIButton!
    
    @IBOutlet weak var emotionGraph: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        emotionViewModel.getEmotions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        emotionViewModel.getEmotions()
    }
    
    private func bindViewModel() {
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
                    self.makeChartaYear()
            })
            .disposed(by: disposeBag)
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
    
    private func makeChartaWeek() {
        // 한주의 감정
        
        // 폰트 설정
        aYearButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        sixMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        aMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        aWeekButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjoBold, size: 16)
        
        // 텍스트 컬러 설정
        aYearButton.setTitleColor(UIColor.lightGray, for: .normal)
        sixMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aWeekButton.setTitleColor(UIColor(rgb: K.brownColor), for: .normal)
        
        emotionNames = []
        emotionsRate = []
        if aWeekEmotion.happiness > 0 {
            emotionsRate.append(aWeekEmotion.happiness)
            emotionNames.append("행복")
        }
        if aWeekEmotion.neutrality > 0 {
            emotionsRate.append(aWeekEmotion.neutrality)
            emotionNames.append("중립")
        }
        if aWeekEmotion.worry > 0 {
            emotionsRate.append(aWeekEmotion.worry)
            emotionNames.append("걱정")
        }
        if aWeekEmotion.sadness > 0 {
            emotionsRate.append(aWeekEmotion.sadness)
            emotionNames.append("슬픔")
        }
        if aWeekEmotion.anger > 0 {
            emotionsRate.append(aWeekEmotion.anger)
            emotionNames.append("분노")
        }
        
        customizeChart(dataPoints: emotionNames, values: emotionsRate.map{ $0 }, title: "한주의 감정")
    }
    
    private func makeChartaMonth() {
        // 한달의 감정
        
        // 폰트 설정
        aYearButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        sixMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        aMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjoBold, size: 16)
        aWeekButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        
        // 텍스트 컬러 설정
        aYearButton.setTitleColor(UIColor.lightGray, for: .normal)
        sixMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aMonthButton.setTitleColor(UIColor(rgb: K.brownColor), for: .normal)
        aWeekButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        emotionNames = []
        emotionsRate = []
        if aMonthEmotion.happiness > 0 {
            emotionsRate.append(aMonthEmotion.happiness)
            emotionNames.append("행복")
        }
        if aMonthEmotion.neutrality > 0 {
            emotionsRate.append(aMonthEmotion.neutrality)
            emotionNames.append("중립")
        }
        if aMonthEmotion.worry > 0 {
            emotionsRate.append(aMonthEmotion.worry)
            emotionNames.append("걱정")
        }
        if aMonthEmotion.sadness > 0 {
            emotionsRate.append(aMonthEmotion.sadness)
            emotionNames.append("슬픔")
        }
        if aMonthEmotion.anger > 0 {
            emotionsRate.append(aMonthEmotion.anger)
            emotionNames.append("분노")
        }
        
        customizeChart(dataPoints: emotionNames, values: emotionsRate.map{ $0 }, title: "한달의 감정")
    }
    
    private func makeChartSixMonth() {
        // 6개월의 감정
        
        // 폰트 설정
        aYearButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        sixMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjoBold, size: 16)
        aMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        aWeekButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        
        // 텍스트 컬러 설정
        aYearButton.setTitleColor(UIColor.lightGray, for: .normal)
        sixMonthButton.setTitleColor(UIColor(rgb: K.brownColor), for: .normal)
        aMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aWeekButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        emotionNames = []
        emotionsRate = []
        if sixMonthEmotion.happiness > 0 {
            emotionsRate.append(sixMonthEmotion.happiness)
            emotionNames.append("행복")
        }
        if sixMonthEmotion.neutrality > 0 {
            emotionsRate.append(sixMonthEmotion.neutrality)
            emotionNames.append("중립")
        }
        if sixMonthEmotion.worry > 0 {
            emotionsRate.append(sixMonthEmotion.worry)
            emotionNames.append("걱정")
        }
        if sixMonthEmotion.sadness > 0 {
            emotionsRate.append(sixMonthEmotion.sadness)
            emotionNames.append("슬픔")
        }
        if sixMonthEmotion.anger > 0 {
            emotionsRate.append(sixMonthEmotion.anger)
            emotionNames.append("분노")
        }
        
        customizeChart(dataPoints: emotionNames, values: emotionsRate.map{ $0 }, title: "6개월의 감정")
    }
    
    private func makeChartaYear() {
        // 1년의 감정
        
        // 폰트 설정
        aYearButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjoBold, size: 16)
        sixMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        aMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        aWeekButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        
        // 텍스트 컬러 설정
        aYearButton.setTitleColor(UIColor(rgb: K.brownColor), for: .normal)
        sixMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aWeekButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        emotionNames = []
        emotionsRate = []
        if aYearEmotion.happiness > 0 {
            emotionsRate.append(aYearEmotion.happiness)
            emotionNames.append("행복")
        }
        if aYearEmotion.neutrality > 0 {
            emotionsRate.append(aYearEmotion.neutrality)
            emotionNames.append("중립")
        }
        if aYearEmotion.worry > 0 {
            emotionsRate.append(aYearEmotion.worry)
            emotionNames.append("걱정")
        }
        if aYearEmotion.sadness > 0 {
            emotionsRate.append(aYearEmotion.sadness)
            emotionNames.append("슬픔")
        }
        if aYearEmotion.anger > 0 {
            emotionsRate.append(aYearEmotion.anger)
            emotionNames.append("분노")
        }
        
        customizeChart(dataPoints: emotionNames, values: emotionsRate.map{ $0 }, title: "1년의 감정")
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
        emotionGraph.holeColor = UIColor(rgb: K.mainColor)
        
        // 센터 텍스트 속성 설정
        let myAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 17)!,
            .foregroundColor: UIColor(rgb: K.brownColor)
        ]
        let myAttrString = NSAttributedString(string: title, attributes: myAttribute)
        emotionGraph.centerAttributedText = myAttrString
        emotionGraph.drawCenterTextEnabled = true
        
        // 엔트리 텍스트 속성 설정
        emotionGraph.entryLabelFont = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 14)

        // 하단 텍스트 속성 설정
        emotionGraph.legend.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 11)!
        emotionGraph.legend.textColor = UIColor(rgb: K.brownColor)
        
        emotionGraph.animate(yAxisDuration: 1, easingOption: .easeInOutCubic)
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        let colors: [UIColor] = [UIColor(rgb: K.goldColor), UIColor(rgb: K.greyColor), UIColor(rgb: K.pupleColor), UIColor(rgb: K.blueColor), UIColor(rgb: K.redColor)]
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
