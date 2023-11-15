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
    
    private lazy var binStatusLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "쓰레기통이 거의 가득 찼습니다.\n얼른 비워주세요!"
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.setLineSpacing(lineSpacing: 20)
    }
    
    let circularProgressView = BinStatusCircularProgressView(frame: CGRect(x: 50, y: 50, width: 230, height: 230))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        config()
    }
    

    private func config() {
        layout()
    }
    
    private func layout() {
        view.addSubviews([
            header,
            binStatusLabel,
            circularProgressView
        ])
        
        header.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        binStatusLabel.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(80)
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
            $0.centerY.equalToSuperview().offset(80)
        }
    }

    @objc func animateProgress() {
        let cp = self.view.viewWithTag(101) as! BinStatusCircularProgressView
        cp.setProgressWithAnimation(duration: 1.0, value: 0.75)
    }
}
