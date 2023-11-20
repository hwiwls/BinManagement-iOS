//
//  MainTabBarViewController.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/17.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarConfig()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func addTopBorder(to tabBar: UITabBar) {
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.customColor.customSuperLightGray.cgColor
        borderLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1.0)
        tabBar.layer.addSublayer(borderLayer)
    }
    
    
    
    private func tabBarConfig() {
        tabBar.barTintColor = .customColor.customRegularLightGray
        tabBar.tintColor = .customColor.customSkyBlue
        tabBar.isTranslucent = false
        
        let homeViewController = UINavigationController(
            rootViewController: MapViewController()
        )
        
        let refrigeratorViewController = UINavigationController(
            rootViewController: SearchBuildingViewController()
        )
        
        let addFoodViewController = UINavigationController(
            rootViewController: MyPageViewController()
        )
        
        homeViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.customColor.customRegularLightGray),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        
        refrigeratorViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "magnifyingglass")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.customColor.customRegularLightGray),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        addFoodViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.customColor.customRegularLightGray),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        let tabItems = [
            homeViewController,
            refrigeratorViewController,
            addFoodViewController
        ]
        
        tabItems.forEach {
            $0.isNavigationBarHidden = true
            $0.navigationBar.isTranslucent = false
        }
        
        setViewControllers(tabItems, animated: true)
        addTopBorder(to: tabBar)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is BinStatusViewController || viewController is AnniversaryHallDrawingsViewController {
            print("Selected BinStatusViewController or BuildingDrawingsViewController")
            tabBar.isHidden = true
        } else {
            print("Selected other view controller")
            tabBar.isHidden = false
        }
        return true
    }
}
