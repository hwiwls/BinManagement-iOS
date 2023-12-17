//
//  SceneDelegate.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let signInVC = SignInViewController()
        let mainTC = MainTabBarViewController()
        let myPageVC = MyPageViewController()
        
        signInVC.onConfirm = { [weak self] code in
            if self?.checkAuthenticationCode(code) == true {
                myPageVC.authenticationCode = code
                
                mainTC.viewControllers?.forEach {
                    if let navVC = $0 as? UINavigationController {
                        navVC.viewControllers.append(myPageVC)
                    }
                }
                
                self?.window?.rootViewController = mainTC
                self?.window?.makeKeyAndVisible()
            }
        }
        
        window?.rootViewController = signInVC
        window?.makeKeyAndVisible()
    }

       
       func checkAuthenticationCode(_ code: String) -> Bool {
           let authenticationCodes = ["R9QL2E", "HTF486"] // 예시 인증 코드 목록
           return authenticationCodes.contains(code)
       }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

