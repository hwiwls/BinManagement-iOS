//
//  StateDataResponse.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/20.
//

struct StateDataResponse: Decodable {
    var count: Int?
    var ret: [StateModel]
}

