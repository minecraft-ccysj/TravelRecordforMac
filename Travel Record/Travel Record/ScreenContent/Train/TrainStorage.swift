//
//  TrainStorage.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/26/26.
//

import Foundation
import SwiftData

@Model
final class TrainStorage{
    //当前支持国家：中国
    var train_country = "" //铁路系统所属国家
    var train_operationCompany = "" //运营商 e.g.东日本
    var train_class = "" //座位等级
    var train_number = "" //车次号e.g.G223
    var train_startCountry = "" // 出发国家
    var train_startCity = "" //出发城市
    var train_startStation = "" //出发车站
    var train_arriveCountry = "" //到达国家
    var train_arriveCity = "" //到达城市
    var train_arriveStation = "" //到达车站
    var train_startDate = Date()
    var train_arriveDate = Date()
    var train_seatCarNumber = "" //车厢号
    var train_seatNumber = "" //座位号
    
    var train_type = "" //列车类型
    var train_vehicleNumber = "" //列车编号
    var train_status = "" //准点/晚点
    
    var train_comment = ""//评价记录
    
    init(train_country: String = "", train_operationCompany: String = "", train_class: String = "", train_number: String = "", train_startCountry: String = "", train_startCity: String = "", train_startStation: String = "", train_arriveCountry: String = "", train_arriveCity: String = "", train_arriveStation: String = "", train_startDate: Date = Date(), train_arriveDate: Date = Date(), train_seatCarNumber: String = "", train_seatNumber: String = "", train_type: String = "", train_vehicleNumber: String = "", train_status: String = "", train_comment: String = "") {
        self.train_country = train_country
        self.train_operationCompany = train_operationCompany
        self.train_class = train_class
        self.train_number = train_number
        self.train_startCountry = train_startCountry
        self.train_startCity = train_startCity
        self.train_startStation = train_startStation
        self.train_arriveCountry = train_arriveCountry
        self.train_arriveCity = train_arriveCity
        self.train_arriveStation = train_arriveStation
        self.train_startDate = train_startDate
        self.train_arriveDate = train_arriveDate
        self.train_seatCarNumber = train_seatCarNumber
        self.train_seatNumber = train_seatNumber
        self.train_type = train_type
        self.train_vehicleNumber = train_vehicleNumber
        self.train_status = train_status
        self.train_comment = train_comment
    }
}
