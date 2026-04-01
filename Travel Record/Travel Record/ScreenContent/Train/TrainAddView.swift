//
//  TrainAddView.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/30/26.
//

import SwiftUI
import SwiftData

struct TrainAddView: View {
    
    @State var train_countryIn = ""
    @State var train_operationCompanyIn = ""
    @State var train_classIn = ""
    @State var train_numberIn = "" //车次号e.g.G223
    @State var train_startCountryIn = "" // 出发国家
    @State var train_startCityIn = "" //出发城市
    @State var train_startStationIn = "" //出发车站
    @State var train_arriveCountryIn = "" //到达国家
    @State var train_arriveCityIn = "" //到达城市
    @State var train_arriveStationIn = "" //到达车站
    @State var train_startDateIn = Date()
    @State var train_arriveDateIn = Date()
    @State var train_seatCarNumberIn = "" //车厢号
    @State var train_seatNumberIn = "" //座位号
    
    @State var train_typeIn = "" //列车类型
    @State var train_vehicleNumberIn = "" //列车编号
    @State var train_statusIn = "" //准点/晚点
    
    @State var train_commentIn = ""//评价记录
    
    @State private var showSuccessAlert = false
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    private let commentLimit = 100
    
    private var commentColor: Color {
        if train_commentIn.count >= commentLimit {
            return .red
        } else if train_commentIn.count > commentLimit * 9 / 10 {
            return .orange
        } else {
            return .secondary
        }
    }
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(){//外观布局
            VStack(alignment: .leading){
                Text("Passenger Information")
                    .font(.title)
                    .padding()
                HStack{
                    Picker("Train System Country:", selection: $train_countryIn){
                        Text("PRC").tag("PRC")
                        Text("JPY").tag("JPY")
                        //Add More here
                    }
                    .onChange(of: train_countryIn) { _, _ in
                        // 国家切换时清空已选公司，避免无效选择
                        train_operationCompanyIn = ""
                    }
                    Spacer()
                    // 只有选了国家后才显示公司选择器
                    if !train_countryIn.isEmpty {//公司选择器
                        HStack{//锁容器用
                            Picker("Operation Company", selection: $train_operationCompanyIn) {
                                train_operationCompanyShow(for: train_countryIn)
                            }
                        }
                        .frame(width: 300, alignment: .leading)
                    }
                }
                .padding()
                HStack{//仓位选择器
                    if !train_countryIn.isEmpty{
                        HStack{//锁容器用
                            Picker("Seat Class", selection: $train_classIn){
                                train_carTypeSeat(for: train_countryIn)
                                Text("Others").tag("Others")
                            }
                        }
                        .frame(width: 400, alignment: .leading)
                    }
                }
                .padding()
                HStack{//填写车号
                    Text("Train Number:")
                    TextField("", text: $train_numberIn)
                        .frame(width: 200)
                }
                .padding()
                
                HStack{
                    Text("Carrage Number:")
                    TextField("", text: $train_seatCarNumberIn)
                        .frame(width: 150)
                    Spacer()
                    Text("Seat Number:")
                    TextField("", text: $train_seatNumberIn)
                        .frame(width: 150)
                }
                .padding()
                
                //以下是出发
                Text("Departure Information")
                    .font(.title)
                    .padding()
                HStack{//出发国家
                    Picker("Departure Country:", selection: $train_startCountryIn){
                        ForEach(TrainData.totalCountry, id: \.self){
                            countries in
                            Text(countries).tag(countries)
                        }
                    }
                }
                
                .padding()
                HStack{//出发城市/车站
                    Text("City:")
                    TextField("",text: $train_startCityIn)
                    Spacer()
                    Text("Station:")
                    TextField("",text: $train_startStationIn)
                }
                .padding()
                HStack{//出发日期
                    DatePicker(selection: $train_startDateIn, label: { Text("Predict Departure Time") })
                }
                .padding()
                
                //以下是到达
                Text("Arrival Information")
                    .font(.title)
                    .padding()
                HStack{//到达国家
                    Picker("Arrival Country:", selection: $train_arriveCountryIn){
                        ForEach(TrainData.totalCountry, id: \.self){
                            countries in
                            Text(countries).tag(countries)
                        }
                    }
                }
                .padding()
                HStack{//到达城市/车站
                    Text("City:")
                    TextField("",text: $train_arriveCityIn)
                    Spacer()
                    Text("Station:")
                    TextField("",text: $train_arriveStationIn)
                }
                .padding()
                HStack{//到达日期
                    DatePicker(selection: $train_arriveDateIn, label: { Text("Predict Arrival Time") })
                }
                .padding()
                
                Text("Vehicle Information")
                    .font(.title)
                    .padding()
                HStack{
                    Text("Train Model:")
                    TextField("", text: $train_typeIn)
                        .frame(width: 200)
                    Spacer()
                    Text("Vehicle Number:")
                    TextField("", text: $train_vehicleNumberIn)
                        .frame(width: 100)
                    
                }
                .padding()
                HStack{//列车状态
                    Picker("Status:",selection: $train_statusIn){
                        Text("Early").tag("Early")
                        Text("Normal").tag("Normal")
                        Text("Late").tag("Late")
                        Text("Cancel").tag("Cancel")
                    }
                }
                .padding()
                Text("Personal Information")
                    .font(.title)
                    .padding()
                VStack(alignment: .leading){
                    HStack{
                        Text("Write comment here:")
                    }
                    ZStack(alignment: .topLeading) {//评论
                        if train_commentIn.isEmpty {
                            Text("Any notes about this flight...")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 6)
                        }

                        TextEditor(text: $train_commentIn)
                            .frame(height: 60)
                            .padding(4)
                            .onChange(of: train_commentIn) { _, newValue in
                                if newValue.count > commentLimit {
                                    train_commentIn = String(newValue.prefix(commentLimit))
                                }
                            }
                    }
                }
                .padding()
                HStack{
                    Button("Cancel"){
                        dismiss()
                    }
                    Button {
                        createNewTrainTrip()
                    } label: {
                        Text("Confirm")
                    }
                }
                .padding()
                
                //成功
                .alert("Success", isPresented: $showSuccessAlert) {
                    Button("OK") {
                        dismiss()
                    }
                } message: {
                    Text("Your trip has been added successfully.")
                }
                // 错误提示
                .alert("Incomplete Information", isPresented: $showErrorAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
        }
        .navigationTitle("Add a New Train Trip")
    }
    
    
    //定义公司
    @ViewBuilder
    private func train_operationCompanyShow(for temp_country: String) -> some View{//分类各个公司，对应train_companyvsCountry组
        if let train_companies = TrainData.train_companyByCountry[temp_country]{
            ForEach(train_companies, id:\.self){
                Text($0).tag($0)
            }
        }else{
            Text("Not Supported").tag("No Supported")
        }
    }
    
    //定义舱位数据
    @ViewBuilder
    private func train_carTypeSeat(for temp_country: String) -> some View{
        if let train_seat = TrainData.train_typeSeatvsCountry[temp_country]{
            let train_highSpeedSeats = Array(train_seat.prefix(6))
            let train_commonSeats = Array(train_seat.dropFirst(6))
            
            Section(header:
            Text("High Speed (G/D/C Series)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            ){
                ForEach(train_highSpeedSeats, id:\.self){
                    Text($0).tag($0)
                }
            }
            Section(header:
            Text("Conventional (Z/T/K/Y Series)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            ){
                ForEach(train_commonSeats, id:\.self){
                    Text($0).tag($0)
                }
            }
        }
    }
    
    //新建
    func createNewTrainTrip(){
        guard !train_numberIn.isEmpty else  {
            showError("Please enter a train number.")
            return
        }
        
        guard !train_seatCarNumberIn.isEmpty else{
            showError("Please enter a carrage number.")
            return
        }
        
        guard !train_seatNumberIn.isEmpty else{
            showError("Please enter a seat number.")
            return
        }
        
        guard !train_startCityIn.isEmpty else{
            showError("Please enter a city you start.")
            return
        }
        
        guard !train_startStationIn.isEmpty else{
            showError("Please enter a station you arrive.")
            return
        }
        
        guard !train_arriveCityIn.isEmpty else{
            showError("Please enter a city you arrive.")
            return
        }
        
        guard !train_arriveStationIn.isEmpty else{
            showError("Please enter a station you arrive.")
            return
        }
        
        let new_TrainTrip = TrainStorage(
            train_country: train_countryIn,
            train_operationCompany: train_operationCompanyIn,
            train_class: train_classIn,
            train_number: train_numberIn,
            train_startCountry: train_startCountryIn,
            train_startCity: train_startCityIn,
            train_startStation: train_startStationIn,
            train_arriveCountry: train_arriveCountryIn,
            train_arriveCity: train_arriveCityIn,
            train_arriveStation: train_arriveStationIn,
            train_startDate: train_startDateIn,
            train_arriveDate: train_arriveDateIn,
            train_seatCarNumber: train_seatCarNumberIn,
            train_seatNumber: train_seatNumberIn,
            train_type: train_typeIn,
            train_vehicleNumber: train_vehicleNumberIn,
            train_status: train_statusIn,
            train_comment: train_commentIn
        )
        
        modelContext.insert(new_TrainTrip)
        showSuccessAlert = true
    }
    
    func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}

#Preview {
    TrainAddView()
}
