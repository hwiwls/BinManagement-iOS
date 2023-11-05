//
//  BuildingDrawingsViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/01.
//

import UIKit

class BuildingDrawingsViewController: UIViewController {

    private lazy var header = BuildingDrawingsTabHeader(frame: .zero)
    
    private lazy var zoomInBtn = UIButton().then {
        $0.backgroundColor = UIColor.customColor.customSuperLightGray
        $0.setImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        $0.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
    }
    
    private lazy var zoomOutBtn = UIButton().then {
        $0.backgroundColor = UIColor.customColor.customSuperLightGray
        $0.setImage(UIImage(systemName: "minus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        $0.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.minimumZoomScale = 1.0
        $0.maximumZoomScale = 10.0
        $0.bounces = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private lazy var imageView = UIImageView().then {
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
            scrollView,
            zoomInBtn,
            zoomOutBtn
        ])
        
        scrollView.addSubview(imageView)
        
        header.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        zoomInBtn.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.top.equalTo(header.snp.bottom).offset(50)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        zoomOutBtn.snp.makeConstraints {
            $0.width.height.equalTo(35)
            $0.top.equalTo(zoomInBtn.snp.bottom).offset(1)
            $0.trailing.equalToSuperview().offset(-20)
        }
      
        scrollView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(50)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(100)
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(418)
            $0.height.equalTo(352)
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        self.scrollView.delegate = self
        
    }

    
    @objc private func zoomIn() {
        scrollView.setZoomScale(scrollView.zoomScale + 1.0, animated: true)
    }
        
    @objc private func zoomOut() {
        scrollView.setZoomScale(scrollView.zoomScale - 1.0, animated: true)
    }
    
}

extension BuildingDrawingsViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    self.imageView
  }
}
