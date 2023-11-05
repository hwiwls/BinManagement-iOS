//
//  BuildingDrawingsViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/01.
//

import UIKit

class BuildingDrawingsViewController: UIViewController {

    private let header = BuildingDrawingsTabHeader(frame: .zero)
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "AnniversaryHallDrawings")
        $0.contentMode = .scaleAspectFit
    }
    
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
            imageView
        ])
        
        header.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
}
