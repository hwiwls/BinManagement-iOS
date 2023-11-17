//
//  BuildingModel.swift
//  BinManagement
//
//  Created by hwijinjeong on 2023/11/17.
//

import UIKit

struct Building {
    let imageName: String
    let name: String
    let information: String
}

let dummyData: [Building] = [
    Building(imageName: "AnniversaryHall", name: "인하대학교 60주년기념관", information: "현재 쓰레기통 공간이 여유롭습니다"),
    // 추가 더미 데이터
    Building(imageName: "HitechCenter", name: "인하대학교 하이테크센터", information: "현재 쓰레기통 공간이 여유롭습니다"),
    Building(imageName: "AnniversaryHall", name: "인하대학교 본관", information: "현재 쓰레기통 공간이 여유롭습니다"),
    Building(imageName: "AnniversaryHall", name: "인하대학교 2호관", information: "현재 쓰레기통 공간이 여유롭습니다"),
    Building(imageName: "AnniversaryHall", name: "인하대학교 4호관", information: "현재 쓰레기통 공간이 여유롭습니다"),
    Building(imageName: "AnniversaryHall", name: "인하대학교 학생회관", information: "현재 쓰레기통 공간이 여유롭습니다"),
    Building(imageName: "AnniversaryHall", name: "인하대학교 5호관(동)", information: "현재 쓰레기통 공간이 여유롭습니다")
]
