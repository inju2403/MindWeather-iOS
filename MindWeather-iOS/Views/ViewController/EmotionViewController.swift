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
    
    var mainColor = 0xFDF5E6 // 메인 색상
    var brownColor = 0x8B4513 // 텍스트 색상

    var goldColor = 0xFFA700 // 행복
    var greyColor = 0xBBBBBB // 중립
    var pupleColor = 0xA575CD // 걱정
    var blueColor = 0x42A5F5 // 슬픔
    var redColor = 0xFF4950 // 분노

    
    @IBOutlet weak var emotionGraph: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let emotions = ["행복", "중립", "걱정", "슬픔", "분노"]
        let goals = [36, 8, 26, 13, 18, 10]
        
        customizeChart(dataPoints: emotions, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
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
        
        emotionGraph.holeColor = UIColor(argb: mainColor)
        emotionGraph.centerText = "나의 감정"
        emotionGraph.drawCenterTextEnabled = true
        emotionGraph.entryLabelFont = UIFont(name: "ArialHebrew", size: 14)
        
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
