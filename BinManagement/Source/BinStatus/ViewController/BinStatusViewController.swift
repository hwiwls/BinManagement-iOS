//
//  BinStatusViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/07.
//

import UIKit
import SnapKit
import Then
import DGCharts

class BinStatusViewController: UIViewController {
    var trashcanId: Int? // trashcan id를 저장할 속성 추가
    
    private lazy var header = BinStatusTabHeader(frame: .zero)
    
    var percentageValue: Float = 0.75
    
    lazy var binNameLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    private lazy var binStatusLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "• 현재 쓰레기통 상태"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    let circularProgressView = BinStatusCircularProgressView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
    
    private lazy var percentageLabel = UILabel().then {
        $0.textColor = UIColor.customColor.customSkyBlue
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    }
    
    private lazy var timeByTimeTrendLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "• 시간별 추이"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    private lazy var chartView = LineChartView().then {
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // trashcanId를 사용해 서버에 요청 보내기
            if let id = trashcanId {
                TrashcanDataManager().getTrashcanDetails(id, self)
                StateDataManager().getStateDetails(StateAPIInput(trashcan_id: id), self)
            }
        
        config()
        
        header.backBtnAction = { [weak self] in
            self?.handleBack()
        }
        
        chartsConfiguration()
    }
    
    private func chartsConfiguration() {
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
    }
    
    private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    private func config() {
        layout()
    }
    
    private func layout() {
        view.addSubviews([
            header,
            binNameLabel,
            binStatusLabel,
            circularProgressView,
            percentageLabel,
            timeByTimeTrendLabel,
            chartView
        ])
        
        header.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        binNameLabel.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        binStatusLabel.snp.makeConstraints {
            $0.top.equalTo( binNameLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        circularProgressView.trackColor = UIColor.customColor.customSuperLightGray
        circularProgressView.progressColor = UIColor.customColor.customSkyBlue
        circularProgressView.center = self.view.center
        circularProgressView.tag = 101
        
        circularProgressView.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(binStatusLabel.snp.bottom).offset(60)
        }
        
        percentageLabel.snp.makeConstraints {
            $0.center.equalTo(circularProgressView)
        }
        
        timeByTimeTrendLabel.snp.makeConstraints {
            $0.top.equalTo(circularProgressView.snp.bottom).offset(90)
            $0.leading.equalToSuperview().offset(20)
        }
        
        chartView.snp.makeConstraints {
            $0.top.equalTo(timeByTimeTrendLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
    }

    @objc func animateProgress() {
        let cp = self.view.viewWithTag(101) as! BinStatusCircularProgressView
        cp.setProgressWithAnimation(duration: 0.5, value: percentageValue)

        // 프로그레스가 업데이트될 때마다 퍼센트 값을 업데이트
        let formattedPercentage = String(format: "%.0f%%", percentageValue * 100)
        percentageLabel.text = formattedPercentage
    }
}
