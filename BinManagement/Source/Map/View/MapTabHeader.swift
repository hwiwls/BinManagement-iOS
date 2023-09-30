//
//  MapTabHeader.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/09/26.
//

import UIKit
import SnapKit
import Then

final class MapTabHeader: UIView {
    private let searchBar = SearchBar(height: 40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews([
                searchBar
        ])
        
        searchBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
    }
}
