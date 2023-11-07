//
//  BinInfoView.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/07.
//

import UIKit
import SnapKit
import Then

class BinInfoView: UIView {
    private let shadow: Bool
    
    lazy var binNameLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "저층부 남자화장실 앞 쓰레기통"
        $0.font = UIFont.systemFont(ofSize: 19, weight: .bold)
    }
    
    private lazy var checkStatusBtn = UIButton().then {
        $0.setTitle("상태 확인하기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.setImage(UIImage(systemName: "arrowshape.turn.up.forward")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.customColor.customSuperLightGray.cgColor
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
    }
    
    init(height: CGFloat = 230, shadow: Bool = true) {
        self.shadow = shadow
        super.init(frame: .zero)
        self.backgroundColor = .white
        layout(height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shadow {
            addShadow()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(height: CGFloat) {
        addSubviews([
            binNameLabel,
            checkStatusBtn
        ])
        
        binNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(45)
            $0.leading.equalToSuperview().offset(20)
        }
        
        checkStatusBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(binNameLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
       
    }
    
}

