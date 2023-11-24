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
        
       
    }

    @objc func animateProgress() {
        let cp = self.view.viewWithTag(101) as! BinStatusCircularProgressView
        cp.setProgressWithAnimation(duration: 0.5, value: percentageValue)

        // 프로그레스가 업데이트될 때마다 퍼센트 값을 업데이트
        let formattedPercentage = String(format: "%.0f%%", percentageValue * 100)
        percentageLabel.text = formattedPercentage
    }
}
