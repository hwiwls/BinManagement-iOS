//
//  StateModel.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/20.
//

struct StateModel: Decodable {
    var date_time: String?
    var percent: Float?
    var full: Int?
    var trashcan_id: Int?
}
