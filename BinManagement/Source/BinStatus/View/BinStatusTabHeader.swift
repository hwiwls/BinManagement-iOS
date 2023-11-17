//
//  BinStatusTabHeader.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/07.
//

import UIKit
import SnapKit
import Then

final class BinStatusTabHeader: UIView {
    
    var backBtnAction: (() -> Void)?
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left")?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    let buildingNameLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "60주년기념관"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private let borderView = UIView().then {
        $0.backgroundColor = UIColor.customColor.customSuperLightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        layout()
        
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActions() {
        backBtn.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }

    @objc private func handleBack() {
        backBtnAction?()
    }
    
    private func layout() {
        self.addSubviews([
            backBtn,
            buildingNameLabel,
            borderView
        ])
        
        backBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(13)
            $0.width.height.equalTo(22)
        }
        
        buildingNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn)
            $0.leading.equalTo(backBtn.snp.trailing).offset(10)
        }
        
        borderView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
