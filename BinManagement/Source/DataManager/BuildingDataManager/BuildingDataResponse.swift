//
//  BuildingDataResponse.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/19.
//

struct BuildingDataResponse: Decodable {
    var count: Int?
    var ret: [BuildingModel]
}
