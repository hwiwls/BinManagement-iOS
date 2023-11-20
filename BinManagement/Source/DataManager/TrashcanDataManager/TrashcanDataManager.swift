//
//  TrashcanDataManager.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/20.
//

import Alamofire

class TrashcanDataManager {
//    func getTrashcanDetails(_ tag: Int, _ viewController: BuildingDrawingsViewController) {
//            AF.request("https://befe-218-148-90-111.ngrok-free.app/trashcan?id=\(tag)", method: .get)
//                .validate()
//                .responseDecodable(of: TrashcanDataResponse.self) { response in
//                    switch response.result {
//                    case .success(let result):
//                        guard let trashcan = result.ret.first else { return }
//                        DispatchQueue.main.async {
//                            viewController.binInfoView.binNameLabel.text = trashcan.location
//                        }
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//            }
//        }
    
    // TrashcanDataManager.swift
    func getTrashcanDetails(_ tag: Int, _ viewController: UIViewController) {
        AF.request("https://b958-218-148-90-111.ngrok-free.app/trashcan?id=\(tag)", method: .get)
            .validate()
            .responseDecodable(of: TrashcanDataResponse.self) { response in
                switch response.result {
                case .success(let result):
                    guard let trashcan = result.ret.first else { return }
                    DispatchQueue.main.async {
                        if let vc = viewController as? AnniversaryHallDrawingsViewController {
                            vc.binInfoView.binNameLabel.text = trashcan.location
                        } else if let vc = viewController as? BinStatusViewController {
                            vc.binNameLabel.text = trashcan.location
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }


}
