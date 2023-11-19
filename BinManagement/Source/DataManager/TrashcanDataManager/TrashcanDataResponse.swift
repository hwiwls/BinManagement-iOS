//
//  TrashcanDataResponse.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/20.
//

struct TrashcanDataResponse: Decodable {
    var count: Int?
    var ret: [TrashcanModel]
}
