//
//  MapViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/09/23.
//
//

import UIKit
import CoreLocation

public let DEFAULT_POSITION = MTMapPointGeo(latitude: 37.449339, longitude: 126.654278)

class MapViewController: UIViewController, MTMapViewDelegate {

    var mapView: MTMapView!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 지도 불러오기
        mapView = MTMapView(frame: self.view.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)

        // 지도의 중심점, 레벨 설정합니다.
        mapView.setMapCenter(MTMapPoint(geoCoord: DEFAULT_POSITION), zoomLevel: -0, animated: true)

        // 위치 권한 요청
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        let mainBuilding = MTMapPOIItem()
        mainBuilding.itemName = "인하대학교 본관"
        mainBuilding.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.449393, longitude: 126.654325))
        mainBuilding.markerType = .redPin
        
        let hitechCenter = MTMapPOIItem()
        hitechCenter.itemName = "인하대학교 하이테크센터"
        hitechCenter.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450755, longitude: 126.657110))
        hitechCenter.markerType = .redPin
        
        let studentHall = MTMapPOIItem()
        studentHall.itemName = "인하대학교 학생회관"
        studentHall.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.449497, longitude: 126.656675))
        studentHall.markerType = .redPin
        
        let KHTCenter = MTMapPOIItem()
        KHTCenter.itemName = "김현태인하드림센터"
        KHTCenter.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.448887, longitude: 126.656124))
        KHTCenter.markerType = .redPin
        
        let building6 = MTMapPOIItem()
        building6.itemName = "6호관"
        building6.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.448206, longitude: 126.655777))
        building6.markerType = .redPin
        
        let building9 = MTMapPOIItem()
        building9.itemName = "9호관"
        building9.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.447543, longitude: 126.655378))
        building9.markerType = .redPin
        
        let building4 = MTMapPOIItem()
        building4.itemName = "4호관"
        building4.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450457, longitude: 126.655167))
        building4.markerType = .redPin
        
        let building2_north = MTMapPOIItem()
        building2_north.itemName = "2호관(북)"
        building2_north.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.451120, longitude: 126.655419))
        building2_north.markerType = .redPin
        
        let building2_east = MTMapPOIItem()
        building2_east.itemName = "2호관(동)"
        building2_east.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450400, longitude: 126.655710))
        building2_east.markerType = .redPin
        
        let building2_south = MTMapPOIItem()
        building2_south.itemName = "2호관(남)"
        building2_south.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450082, longitude: 126.654864))
        building2_south.markerType = .redPin
        
        let building5_north = MTMapPOIItem()
        building5_north.itemName = "5호관(북)"
        building5_north.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.451691, longitude: 126.653427))
        building5_north.markerType = .redPin
        
        let building5_east = MTMapPOIItem()
        building5_east.itemName = "5호관(동)"
        building5_east.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450912, longitude: 126.653741))
        building5_east.markerType = .redPin
        
        let building5_south = MTMapPOIItem()
        building5_south.itemName = "5호관(남)"
        building5_south.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450792, longitude: 126.652821))
        building5_south.markerType = .redPin
        
        let building5_west = MTMapPOIItem()
        building5_west.itemName = "5호관(서)"
        building5_west.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.451435, longitude: 126.652360))
        building5_west.markerType = .redPin
        
        let anniversaryHall = MTMapPOIItem()
        anniversaryHall.itemName = "60주년기념관"
        anniversaryHall.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.450891, longitude: 126.654289))
        anniversaryHall.markerType = .redPin
        
        let westLakeBuilding = MTMapPOIItem()
        westLakeBuilding.itemName = "서호관"
        westLakeBuilding.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.451481, longitude: 126.651266))
        westLakeBuilding.markerType = .redPin
        
        let studentClubHall = MTMapPOIItem()
        studentClubHall.itemName = "나빌레관"
        studentClubHall.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.451660, longitude: 126.650700))
        studentClubHall.markerType = .redPin
        
        let jungseokMemorialLibrary = MTMapPOIItem()
        jungseokMemorialLibrary.itemName = "정석학술정보관"
        jungseokMemorialLibrary.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.449314, longitude: 126.652474))
        jungseokMemorialLibrary.markerType = .redPin
        
        let lawSchool = MTMapPOIItem()
        lawSchool.itemName = "로스쿨관"
        lawSchool.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.448368, longitude: 126.651933))
        lawSchool.markerType = .redPin
        
        let centerForContinuingEducation = MTMapPOIItem()
        centerForContinuingEducation.itemName = "평생교육원"
        centerForContinuingEducation.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.447368, longitude: 126.654133))
        centerForContinuingEducation.markerType = .redPin
        
        mapView.addPOIItems([mainBuilding])
        mapView.addPOIItems([hitechCenter])
        mapView.addPOIItems([studentHall])
        mapView.addPOIItems([KHTCenter])
        mapView.addPOIItems([building6])
        mapView.addPOIItems([building9])
        mapView.addPOIItems([building4])
        mapView.addPOIItems([building2_north])
        mapView.addPOIItems([building2_east])
        mapView.addPOIItems([building2_south])
        mapView.addPOIItems([building5_north])
        mapView.addPOIItems([building5_east])
        mapView.addPOIItems([building5_south])
        mapView.addPOIItems([building5_west])
        mapView.addPOIItems([anniversaryHall])
        mapView.addPOIItems([westLakeBuilding])
        mapView.addPOIItems([studentClubHall])
        mapView.addPOIItems([jungseokMemorialLibrary])
        mapView.addPOIItems([lawSchool])
        mapView.addPOIItems([centerForContinuingEducation])
        
        
    }
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        if let currentLocationPointGeo = location?.mapPointGeo() {
            print("MTMapView updateCurrentLocation (\(currentLocationPointGeo.latitude),\(currentLocationPointGeo.longitude)) accuracy (\(accuracy))")
        }
    }
    
    func mapView(_ mapView: MTMapView, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle)) degrees")
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
