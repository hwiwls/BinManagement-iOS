//
//  ViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/09/23.
//

//jira commit 테스트입니닷

import UIKit

class ViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MTMapView(frame: self.view.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)
    }


}

