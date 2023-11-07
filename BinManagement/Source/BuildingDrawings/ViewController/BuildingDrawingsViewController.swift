//
//  BuildingDrawingsViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/01.
//

import UIKit
import SnapKit
import Then

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
        $0.maximumZoomScale = 2.56
        $0.bounces = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private lazy var imageView = UIImageView().then {
        $0.image = UIImage(named: "AnniversaryHallDrawings")
        $0.contentMode = .scaleAspectFit
        
    }
    
    private lazy var marker01 = UIImageView().then {
        $0.image = UIImage(named: "YellowMarker")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var marker02 = UIImageView().then {
        $0.image = UIImage(named: "YellowMarker")
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
        
        scrollView.addSubviews([
            imageView,
            marker01,
            marker02
        ])
        
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
            $0.top.equalTo(header.snp.bottom).offset(70)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(200)
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(380)
            $0.height.equalTo(79.8)
            $0.centerX.equalTo(scrollView)
            $0.top.equalTo(scrollView.snp.top).offset(180)
        }
        
        marker01.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(imageView.snp.top).offset(10)
            $0.leading.equalTo(imageView.snp.leading).offset(50)
        }
        
        marker02.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(imageView.snp.top).offset(10)
            $0.leading.equalTo(imageView.snp.leading).offset(270)
        }
        
        self.scrollView.delegate = self
        
    }

    private func updateMarkerPositionAndSize() {
        // 현재 확대 비율
        let zoomScale = scrollView.zoomScale

        // marker01의 초기 위치 및 크기
        let initialMarkerSize: CGFloat = 40.0
        let initialMarkerTopOffset: CGFloat = 10.0
        let initialMarkerLeadingOffset: CGFloat = 50.0

        // 새로운 크기와 위치 계산
        let newMarkerSize = initialMarkerSize * zoomScale
        let newMarkerTopOffset = initialMarkerTopOffset * zoomScale
        let newMarkerLeadingOffset = initialMarkerLeadingOffset * zoomScale

        // marker01의 제약 조건 업데이트
        marker01.snp.updateConstraints {
            $0.width.height.equalTo(newMarkerSize)
            $0.top.equalTo(imageView.snp.top).offset(newMarkerTopOffset)
            $0.leading.equalTo(imageView.snp.leading).offset(newMarkerLeadingOffset)
        }
        
        let initialMarker02Size: CGFloat = 40.0
        let initialMarker02TopOffset: CGFloat = 10.0
        let initialMarker02LeadingOffset: CGFloat = 270.0

        // 새로운 크기와 위치 계산
        let newMarker02Size = initialMarker02Size * zoomScale
        let newMarker02TopOffset = initialMarker02TopOffset * zoomScale
        let newMarker02LeadingOffset = initialMarker02LeadingOffset * zoomScale
        
        // marker02의 제약 조건 업데이트
        marker02.snp.updateConstraints {
            $0.width.height.equalTo(newMarker02Size)
            $0.top.equalTo(imageView.snp.top).offset(newMarker02TopOffset)
            $0.leading.equalTo(imageView.snp.leading).offset(newMarker02LeadingOffset)
        }
    }

    private func updateMarkerPositionForZoomOut() {
        // 현재 marker01의 프레임을 가져옵니다.
        let currentMarkerFrame = marker01.frame

        // imageView의 현재 프레임을 가져옵니다.
        let imageViewFrame = imageView.frame

        // marker01의 현재 크기와 위치를 imageView의 기준으로 계산합니다.
        let currentMarkerSize = CGSize(width: currentMarkerFrame.size.width, height: currentMarkerFrame.size.height)
        let currentMarkerTopOffset = currentMarkerFrame.minY - imageViewFrame.minY
        let currentMarkerLeadingOffset = currentMarkerFrame.minX - imageViewFrame.minX

        // marker01을 0.625배로 축소합니다.
        let newMarkerSize = currentMarkerSize.width * 0.625
        let newMarkerTopOffset = currentMarkerTopOffset * 0.625
        let newMarkerLeadingOffset = currentMarkerLeadingOffset * 0.625

        // marker01의 크기와 위치를 업데이트합니다.
        marker01.snp.updateConstraints {
            $0.width.height.equalTo(newMarkerSize)
            $0.top.equalTo(imageView.snp.top).offset(newMarkerTopOffset)
            $0.leading.equalTo(imageView.snp.leading).offset(newMarkerLeadingOffset)
        }
        
        let currentMarker02Frame = marker02.frame

        // marker01의 현재 크기와 위치를 imageView의 기준으로 계산합니다.
        let currentMarker02Size = CGSize(width: currentMarker02Frame.size.width, height: currentMarker02Frame.size.height)
        let currentMarker02TopOffset = currentMarker02Frame.minY - imageViewFrame.minY
        let currentMarker02LeadingOffset = currentMarker02Frame.minX - imageViewFrame.minX

        // marker01을 0.625배로 축소합니다.
        let newMarker02Size = currentMarker02Size.width * 0.625
        let newMarker02TopOffset = currentMarker02TopOffset * 0.625
        let newMarker02LeadingOffset = currentMarker02LeadingOffset * 0.625
        
        // marker02의 크기와 위치도 업데이트합니다.
        marker02.snp.updateConstraints {
            $0.width.height.equalTo(newMarker02Size)
            $0.top.equalTo(imageView.snp.top).offset(newMarker02TopOffset)
            $0.leading.equalTo(imageView.snp.leading).offset(newMarker02LeadingOffset)
        }
    }

    
    @objc private func zoomIn() {
        scrollView.setZoomScale(scrollView.zoomScale * 1.6, animated: true)
        updateMarkerPositionAndSize()
        
    }
    
    @objc private func zoomOut() {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.zoomScale * 0.625, animated: true)
            updateMarkerPositionForZoomOut()
        }
    }
   
}

extension BuildingDrawingsViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    self.imageView
  }
}
