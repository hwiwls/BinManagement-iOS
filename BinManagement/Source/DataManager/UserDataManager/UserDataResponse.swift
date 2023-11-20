//
//  UserDataResponse.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/20.
//

struct UserDataResponse: Decodable {
    var count: Int?
    var ret: [UserModel]
}
