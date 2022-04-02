//
//  EmotionViewController.swift
//  MindWeather-iOS
//
//  Created by 이승주 on 2021/06/29.
//

import UIKit

import Charts
import RxCocoa
import RxSwift

class EmotionViewController: BaseViewController {
    
    let emotionViewModel = EmotionViewModel(service: ServiceInjector.injectDiaryService())
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
        
        // 감정 그래프에 대한 노티피케이션 추가 - 일기 추가, 일기 수정, 일기 삭제에서 사용
        NotificationCenter.default.addObserver(
            self, selector: #selector(updateEmotions),
            name: Notification.Name(rawValue: NOTIFICATION.API.updateEmotions),
            object:  nil
        )
        
        setUI()
        bindViewModel()
        emotionViewModel.emotions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emotionGraph.animate(yAxisDuration: 1, easingOption: .easeInOutCubic)
    }
    
    @objc private func updateEmotions() {
        emotionViewModel.emotions()
    }
    
    private func bindViewModel() {
        emotionViewModel.aWeekEmotion
            .subscribe(
                onNext: {  [weak self] value in
                    self?.aWeekEmotion = value
            })
            .disposed(by: disposeBag)
        
        emotionViewModel.aMonthEmotion
            .subscribe(
                onNext: { [weak self] value in
                    self?.aMonthEmotion = value
            })
            .disposed(by: disposeBag)
        
        emotionViewModel.sixMonthEmotion
            .subscribe(
                onNext: { [weak self] value in
                    self?.sixMonthEmotion = value
            })
            .disposed(by: disposeBag)
        
        emotionViewModel.aYearEmotion
            .subscribe(
                onNext: { [weak self] value in
                    self?.aYearEmotion = value
                    self?.makeChartaYear()
            })
            .disposed(by: disposeBag)
    }
    
    private func setUI() {
        self.navigationController?.isNavigationBarHidden = true
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
        setEmotionButtonAttribute(with: aWeekButton)
        setEmotionsRate(with: aWeekEmotion)
        customizeChart(
            dataPoints: emotionNames,
            values: emotionsRate.map{ $0 },
            title: Constant.aWeekEmotionTitle
        )
    }

    private func makeChartaMonth() {
        setEmotionButtonAttribute(with: aMonthButton)
        setEmotionsRate(with: aMonthEmotion)
        customizeChart(
            dataPoints: emotionNames,
            values: emotionsRate.map{ $0 },
            title: Constant.aMonthEmotionTitle
        )
    }

    private func makeChartSixMonth() {
        setEmotionButtonAttribute(with: sixMonthButton)
        setEmotionsRate(with: sixMonthEmotion)
        customizeChart(
            dataPoints: emotionNames,
            values: emotionsRate.map{ $0 },
            title: Constant.sixMonthEmotionTitle
        )
    }

    private func makeChartaYear() {
        setEmotionButtonAttribute(with: aYearButton)
        setEmotionsRate(with: aYearEmotion)
        customizeChart(
            dataPoints: emotionNames,
            values: emotionsRate.map{ $0 },
            title: Constant.aYearEmotionTitle
        )
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
        emotionGraph.holeColor = UIColor(rgb: Constant.mainColor)
        
        // 센터 텍스트 속성 설정
        let myAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 17)!,
            .foregroundColor: UIColor(rgb: Constant.brownColor)
        ]
        let myAttrString = NSAttributedString(string: title, attributes: myAttribute)
        emotionGraph.centerAttributedText = myAttrString
        emotionGraph.drawCenterTextEnabled = true
        
        // 엔트리 텍스트 속성 설정
        emotionGraph.entryLabelFont = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 14)

        // 하단 텍스트 속성 설정
        emotionGraph.legend.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 11)!
        emotionGraph.legend.textColor = UIColor(rgb: Constant.brownColor)
        
        emotionGraph.animate(yAxisDuration: 1, easingOption: .easeInOutCubic)
    }

    private func setEmotionButtonAttribute(with periodButton: UIButton) {
        aYearButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        sixMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        aMonthButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)
        aWeekButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjo, size: 16)

        aYearButton.setTitleColor(UIColor.lightGray, for: .normal)
        sixMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aMonthButton.setTitleColor(UIColor.lightGray, for: .normal)
        aWeekButton.setTitleColor(UIColor.lightGray, for: .normal)

        periodButton.titleLabel?.font = UIFont.AppleSDGothic(type: .NanumMyeongjoBold, size: 16)
        periodButton.setTitleColor(UIColor(rgb: Constant.brownColor), for: .normal)
    }

    private func setEmotionsRate(with period: Emotion) {
        emotionsRate = []
        emotionNames = []

        if period.happiness > 0 {
            emotionsRate.append(period.happiness)
            emotionNames.append(Constant.happinessName)
        }
        if period.neutrality > 0 {
            emotionsRate.append(period.neutrality)
            emotionNames.append(Constant.neutralityName)
        }
        if period.worry > 0 {
            emotionsRate.append(period.worry)
            emotionNames.append(Constant.worryName)
        }
        if period.sadness > 0 {
            emotionsRate.append(period.sadness)
            emotionNames.append(Constant.sadnessName)
        }
        if period.anger > 0 {
            emotionsRate.append(period.anger)
            emotionNames.append(Constant.angerName)
        }
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        let colors: [UIColor] = [
            UIColor(rgb: Constant.goldColor),
            UIColor(rgb: Constant.greyColor),
            UIColor(rgb: Constant.pupleColor),
            UIColor(rgb: Constant.blueColor),
            UIColor(rgb: Constant.redColor)
        ]
        return colors
    }
}
