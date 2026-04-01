//
//  FlightStorage.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/14/26.
//

import Foundation
import SwiftData

@Model
final class FlightStorage{//储存飞行数据：乘客信息（航空公司,航班编号，起飞地，降落地，预计起飞时间，预计降落时间，座位号，舱位等级，航站楼，登机口，状态），飞机信息（机型，注册编号）
    var airline = ""//航空公司string
    var number:Int = 0//航班编号int
    var DEP = ""//起飞地
    var ARR = ""//降落地
    var DEP_Time = Date()//DATE
    var ARR_Time = Date()//DATE
    var Seat = ""
    var Class = ""
    var DEP_Terminal = ""
    var ARR_Terminal = ""
    var BoardGate = ""
    var Status = ""
    var Aircraft = ""
    var RegNumber = ""
    var flight_comment = ""
    
    init(airline: String = "", number: Int, DEP: String = "", ARR: String = "", DEP_Time: Date = Date(), ARR_Time: Date = Date(), Seat: String = "", Class: String = "", DEP_Terminal: String = "", ARR_Terminal: String = "", BoardGate: String = "", Status: String = "", Aircraft: String = "", RegNumber: String = "", flight_comment: String = "") {
        self.airline = airline
        self.number = number
        self.DEP = DEP
        self.ARR = ARR
        self.DEP_Time = DEP_Time
        self.ARR_Time = ARR_Time
        self.Seat = Seat
        self.Class = Class
        self.DEP_Terminal = DEP_Terminal
        self.ARR_Terminal = ARR_Terminal
        self.BoardGate = BoardGate
        self.Status = Status
        self.Aircraft = Aircraft
        self.RegNumber = RegNumber
        self.flight_comment = flight_comment
    }
}
