//
//  LineChartViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/19.
//

import UIKit
import DGCharts

class LineChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let chartView = LineChartView()
        chartView.backgroundColor = .white

        // X-axis configuration
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"])
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false // Hide X-axis grid lines

        // Left Y-axis configuration
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.drawLabelsEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawAxisLineEnabled = false // Hide Y-axis line
        
        // Right Y-axis configuration
        let rightAxis = chartView.rightAxis
        rightAxis.drawLabelsEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.drawAxisLineEnabled = false // Hide Y-axis line

        // Add data points to LineChartView
        let dataPoints: [ChartDataEntry] = [
            ChartDataEntry(x: 0, y: 10),
            ChartDataEntry(x: 1, y: 10),
            ChartDataEntry(x: 2, y: 10),
            ChartDataEntry(x: 3, y: 10),
            ChartDataEntry(x: 4, y: 10),
            ChartDataEntry(x: 5, y: 10),
            ChartDataEntry(x: 6, y: 10),
            ChartDataEntry(x: 7, y: 10),
            ChartDataEntry(x: 8, y: 0),
            ChartDataEntry(x: 9, y: 2),
            ChartDataEntry(x: 10, y: 3),
            ChartDataEntry(x: 11, y: 4),
            ChartDataEntry(x: 12, y: 5.5),
            ChartDataEntry(x: 13, y: 7),
            ChartDataEntry(x: 14, y: 8.5),
            ChartDataEntry(x: 15, y: 0),
            ChartDataEntry(x: 16, y: 5),
            ChartDataEntry(x: 17, y: 6),
            ChartDataEntry(x: 18, y: 7),
            ChartDataEntry(x: 19, y: 9),
            ChartDataEntry(x: 20, y: 10),
            ChartDataEntry(x: 21, y: 10),
            ChartDataEntry(x: 22, y: 10),
            ChartDataEntry(x: 23, y: 10)
        ]

        let dataSet = LineChartDataSet(entries: dataPoints, label: "쓰레기통 시간별 추이")
        dataSet.drawValuesEnabled = false // Hide Y-axis values
        dataSet.drawCirclesEnabled = true // Show circles at data points
        dataSet.circleRadius = 3.0 // Set the circle radius to a smaller value
        dataSet.setColor(UIColor.customColor.customBlue)
        dataSet.circleColors = [UIColor.customColor.customBlue]

        
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data

        // Hide additional grid lines
        chartView.xAxis.gridLineDashLengths = [0] // Hide X-axis grid lines
        chartView.leftAxis.gridLineDashLengths = [0] // Hide left Y-axis grid lines
        chartView.rightAxis.gridLineDashLengths = [0] // Hide right Y-axis grid lines

        view.addSubview(chartView)

        chartView.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 200)
    }
}
