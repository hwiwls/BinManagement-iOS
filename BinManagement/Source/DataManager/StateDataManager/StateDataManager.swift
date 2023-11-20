//
//  StateDataManager.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/20.
//

import Alamofire

class StateDataManager {
    func getStateDetails(_ parameters: StateAPIInput, _ viewController: BinStatusViewController) {
            AF.request("https://befe-218-148-90-111.ngrok-free.app/state?trashcan_id=\(parameters.trashcan_id!)", method: .get, parameters: parameters)
                .validate()
                .responseDecodable(of: StateDataResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let state = result.ret.first, let percent = state.percent {
                            DispatchQueue.main.async {
                                viewController.percentageValue = percent
                                viewController.animateProgress()
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
            }
        }

}
