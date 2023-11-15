//
//  SearchBuildingTapHeader.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/15.
//
import UIKit
import SnapKit
import Then

final class SearchBuildingTabHeader: UIView {
    private let searchBar = SearchBar(height: 40)
    
    private let borderView = UIView().then {
        $0.backgroundColor = UIColor.customColor.customSuperLightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews([
                searchBar,
                borderView
        ])
        
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(5)
        }
        
        borderView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
