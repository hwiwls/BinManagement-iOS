//
//  BinStatusViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/07.
//

import UIKit
import SnapKit
import Then

class BinStatusViewController: UIViewController {
    private lazy var header = BinStatusTabHeader(frame: .zero)
    
    let percentageValue: Float = 0.75
    
    private lazy var binStatusLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "쓰레기통이 거의 가득 찼습니다.\n얼른 비워주세요!"
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.setLineSpacing(lineSpacing: 20)
    }
    
    let circularProgressView = BinStatusCircularProgressView(frame: CGRect(x: 50, y: 50, width: 230, height: 230))
    
    private lazy var percentageLabel = UILabel().then {
        $0.textColor = UIColor.customColor.customSkyBlue
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
            binStatusLabel,
            circularProgressView,
            percentageLabel
        ])
        
        header.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        binStatusLabel.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(60)
            $0.leading.equalToSuperview().offset(20)
        }
        
        circularProgressView.trackColor = UIColor.customColor.customSuperLightGray
        circularProgressView.progressColor = UIColor.customColor.customSkyBlue
        circularProgressView.center = self.view.center
        circularProgressView.tag = 101
        self.perform(#selector(animateProgress), with: nil, afterDelay: 2.0)
        
        circularProgressView.snp.makeConstraints {
            $0.width.height.equalTo(230)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(90)
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
