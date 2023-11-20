//
//  SearchBar.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/09/26.
//

import UIKit
import SnapKit
import Then

final class SearchBar: UIView, UITextFieldDelegate {
    var onSearchButtonClicked: ((String) -> Void)?
    
    let textField = UITextField().then {
        $0.placeHolder(
            string: "건물 검색",
            color: .lightGray
        )
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.addLeftPadding()
        $0.returnKeyType = .search // 키보드의 리턴 키를 검색으로 변경
    }
    
    let searchStart = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
    }
    
    private let shadow: Bool
    
    init(height: CGFloat = 40, shadow: Bool = true) {
        self.shadow = shadow
        super.init(frame: .zero)
        layout(height: height)
        
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // 키보드를 내립니다.
            if let text = textField.text {
                onSearchButtonClicked?(text) // 검색어를 이용해 건물을 필터링합니다.
            }
            return true
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
        backgroundColor = .white
        layer.cornerRadius = 22
        
        addSubviews([
            textField,
            searchStart
        ])
        
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        searchStart.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.height.equalTo(18)
            $0.width.equalTo(19)
            $0.leading.equalToSuperview().inset(12)
        }
    }
}
