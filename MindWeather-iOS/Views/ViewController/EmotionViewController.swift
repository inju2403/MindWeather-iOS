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
    
    var brownColor = "#8B4513" // 텍스트 색상

    var goldColor = "#FFA700" // 행복
    var greyColor = "#BBBBBB" // 중립
    var pupleColor = "#A575CD" // 걱정
    var blueColor = "#42A5F5" // 슬픔
    var redColor = "#FF4950" // 분노

    
    @IBOutlet weak var emotionGraph: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let emotions = ["행복", "중립", "걱정", "슬픔", "분노"]
        let goals = [6, 8, 26, 30, 8, 10]
        
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
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
}
