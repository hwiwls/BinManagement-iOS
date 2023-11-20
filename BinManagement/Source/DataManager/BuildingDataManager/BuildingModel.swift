//
//  BuildingModel.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/18.
//

struct BuildingModel: Decodable {
    var id: Int?
    var name: String?
    var img: String? {
        didSet {
            img = img?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
    }
}
