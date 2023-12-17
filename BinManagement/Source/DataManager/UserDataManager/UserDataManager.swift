//
//  UserDataManager.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/20.
//

import Alamofire

class UserDataManager {
    func userDataManager(_ viewController: SignInViewController) {
        AF.request("https://a1d7-218-148-90-111.ngrok-free.app/user", method: .get)
            .validate()
            .responseDecodable(of: UserDataResponse.self) { response in
                switch response.result {
                case .success(let result):
                    if let authenticationCode = viewController.codeTextField.text,
                       let matchedUser = result.ret.first(where: { $0.authentication_code == authenticationCode }) {
                        DispatchQueue.main.async {
                            viewController.navigationController?.pushViewController(MainTabBarViewController(), animated: true)
                            if let myPageVC = viewController.navigationController?.viewControllers.first(where: { $0 is MyPageViewController }) as? MyPageViewController {
                                myPageVC.authenticationCode = matchedUser.authentication_code
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            // 인증 실패 처리
                            print("인증 실패")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        // 에러 처리
                        print("네트워크 에러")
                    }
                }
            }
    }
}

