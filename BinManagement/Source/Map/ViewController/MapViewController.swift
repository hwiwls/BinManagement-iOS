//
//  MapViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/09/23.
//
//

import UIKit
import CoreLocation
import SnapKit
import Then

public let DEFAULT_POSITION = MTMapPointGeo(latitude: 37.450755, longitude: 126.657110)

class MapViewController: UIViewController, MTMapViewDelegate {

    var mapView: MTMapView!
    
    var locationManager: CLLocationManager!
    
    private let header = MapTabHeader(frame: .zero)
    
    private lazy var buildingInfoView = MapBuildingInfoView(height: 280)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 지도 불러오기
        mapView = MTMapView(frame: self.view.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)

        // 지도의 중심점, 레벨 설정
        mapView.setMapCenter(MTMapPoint(geoCoord: DEFAULT_POSITION), zoomLevel: -0, animated: true)

        // 위치 권한 요청
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let hitechCenter = MTMapPOIItem()
        hitechCenter.itemName = "하이테크센터"
        hitechCenter.tag = 2
        hitechCenter.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450755, longitude: 126.657110))
        hitechCenter.customImageName = "GreenMarker"
        hitechCenter.markerType = .customImage
        hitechCenter.markerSelectedType = .customImage
        
        let anniversaryHall = MTMapPOIItem()
        anniversaryHall.itemName = "60주년기념관"
        anniversaryHall.tag = 1
        anniversaryHall.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450891, longitude: 126.654289))
        anniversaryHall.customImageName = "GreenMarker"
        anniversaryHall.markerType = .customImage
        anniversaryHall.markerSelectedType = .customImage
        
        let studentHall = MTMapPOIItem()
        studentHall.itemName = "학생회관"
        studentHall.tag = 3
        studentHall.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.449503, longitude: 126.656687))
        studentHall.customImageName = "GreenMarker"
        studentHall.markerType = .customImage
        studentHall.markerSelectedType = .customImage
        
        let building02 = MTMapPOIItem()
        building02.itemName = "2호관"
        building02.tag = 4
        building02.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.451121, longitude: 126.655369))
        building02.customImageName = "GreenMarker"
        building02.markerType = .customImage
            building02.markerSelectedType = .customImage
        
        let building05 = MTMapPOIItem()
        building05.itemName = "5호관_동"
        building05.tag = 5
        building05.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.451049, longitude: 126.653796))
        building05.customImageName = "GreenMarker"
        building05.markerType = .customImage
        building05.markerSelectedType = .customImage
        
        let mainBuilding = MTMapPOIItem()
        mainBuilding.itemName = "인하대학교 본관"
        mainBuilding.tag = 6
        mainBuilding.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.449383, longitude: 126.654332))
        mainBuilding.customImageName = "GreenMarker"
        mainBuilding.markerType = .customImage
        mainBuilding.markerSelectedType = .customImage
       
        mapView.addPOIItems([hitechCenter])
        mapView.addPOIItems([anniversaryHall])
        mapView.addPOIItems([studentHall])
        mapView.addPOIItems([building02])
        mapView.addPOIItems([building05])
        mapView.addPOIItems([mainBuilding])
        
        buildingInfoView.isHidden = true
        
        config()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapBuildingInfoTap))
        buildingInfoView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleMapBuildingInfoTap() {
        let buildingDrawingsVC = BuildingDrawingsViewController()
        navigationController?.pushViewController(buildingDrawingsVC, animated: true)
    }
    
    private func config() {
        layout()
    }
    
    private func layout() {
        view.addSubviews([
            header,
            buildingInfoView
        ])
        
        header.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        buildingInfoView.snp.makeConstraints {
            $0.height.equalTo(280)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        if let currentLocationPointGeo = location?.mapPointGeo() {
            print("MTMapView updateCurrentLocation (\(currentLocationPointGeo.latitude),\(currentLocationPointGeo.longitude)) accuracy (\(accuracy))")
        }
    }
    
    func mapView(_ mapView: MTMapView, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle)) degrees")
    }
    
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        let tag = poiItem.tag
        let dataManager = BuildingDataManager()
        dataManager.getBuildingDetails(tag, self)
        return true
    }
  
    
    func updateBuildingInfoView(building: BuildingModel) {
        buildingInfoView.buildingLabel.text = building.name
        if let urlString = building.img?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
               DispatchQueue.global().async {
                   do {
                       let data = try Data(contentsOf: url)
                       if let image = UIImage(data: data) {
                           DispatchQueue.main.async {
                               self.buildingInfoView.imageView.image = image
                               self.buildingInfoView.isHidden = false
                           }
                       } else {
                           print("Failed to make image")
                       }
                   } catch {
                       print("Failed to load image data")
                   }
               }
        } else {
            print("Invalid URL")
        }
    }




}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    self.mapView.showCurrentLocationMarker = true
                    self.mapView.currentLocationTrackingMode = .onWithoutHeading
                }
            }
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
        case .denied:
            print("GPS 권한 요청 거부됨")
        default:
            print("GPS: Default")
        }
    }

}
