//
//  BuildingDataManager.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/18.
//

import Alamofire
// client와 server를 연결
class BuildingDataManager {
    func buildingDataManager(_ parameters: BuildingAPIInput, _ viewController: SearchBuildingViewController) {
        AF.request("https://a1d7-218-148-90-111.ngrok-free.app/building", method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: BuildingDataResponse.self) { response in
                switch response.result {
                case .success(let result):
                    viewController.successAPI(result.ret)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func getBuildingDetails(_ tag: Int, _ viewController: MapViewController) {
        AF.request("https://a1d7-218-148-90-111.ngrok-free.app/buildingid=\(tag)", method: .get)
            .validate()
            .responseDecodable(of: BuildingDataResponse.self) { response in
                switch response.result {
                case .success(let result):
                    guard let building = result.ret.first else { return }
                    DispatchQueue.main.async {
                        viewController.updateBuildingInfoView(building: building)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }

}
