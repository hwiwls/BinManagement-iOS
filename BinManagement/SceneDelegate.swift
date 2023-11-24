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
        // local noti
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings() { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    let nContents = UNMutableNotificationContent()
                    nContents.badge = 1
                    nContents.title = "미래를담다"
                    nContents.body = "현재 60주년 고층부 쓰레기통(1층)이 가득찼습니다. 가능한 빨리 비워주세요!"
                    nContents.sound = UNNotificationSound.default
                    nContents.userInfo = ["name":"HTF486"]

                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

                    let request = UNNotificationRequest(identifier: "NotiTest", content: nContents, trigger: trigger)

                    UNUserNotificationCenter.current().add(request)
                }
            }
        }
    }
    

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

