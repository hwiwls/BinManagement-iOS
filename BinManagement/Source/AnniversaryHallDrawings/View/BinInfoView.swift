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
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 19, weight: .bold)
    }

    var checkStatusButtonTapped: (() -> Void)?
    private lazy var checkStatusBtn = UIButton().then {
        $0.setTitle("상태 확인하기", for: .normal)
        $0.addTarget(self, action: #selector(checkStatusButtonTappedAction), for: .touchUpInside)
    }
    
    @objc private func checkStatusButtonTappedAction() {
        checkStatusButtonTapped?()
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
            addShadow02()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout(height: CGFloat) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrowshape.turn.up.forward")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        config.imagePadding = 10
        config.background.strokeColor = UIColor.customColor.customRegularLightGray
        config.background.strokeWidth = 1
        config.cornerStyle = .fixed
        
        var titleAttr = AttributedString.init("상태 확인하기")
        titleAttr.foregroundColor = .black
        titleAttr.font = .systemFont(ofSize: 16.0, weight: .light)
        config.attributedTitle = titleAttr
        config.baseForegroundColor = UIColor.black
        
        
        checkStatusBtn.configuration = config
        
        
        addSubviews([
            binNameLabel,
            checkStatusBtn
        ])
        
        binNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(20)
        }
        
        checkStatusBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(binNameLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
