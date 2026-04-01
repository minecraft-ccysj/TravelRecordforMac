//
//  TrainEditView.swift
//  Travel Record
//
//  Created by Christophe Lee on 3/31/26.
//

import SwiftUI
import SwiftData

struct TrainEditView: View {
    @Bindable var train: TrainStorage
    
    @Environment(\.dismiss) var dismiss
    
    @State private var train_countryIn: String
    @State private var train_operationCompanyIn: String
    @State private var train_classIn: String
    @State private var train_numberIn: String //车次号e.g.G223
    @State private var train_startCountryIn: String // 出发国家
    @State private var train_startCityIn: String //出发城市
    @State private var train_startStationIn: String //出发车站
    @State private var train_arriveCountryIn: String //到达国家
    @State private var train_arriveCityIn: String //到达城市
    @State private var train_arriveStationIn : String //到达车站
    @State private var train_startDateIn:Date
    @State private var train_arriveDateIn:Date
    @State private var train_seatCarNumberIn: String //车厢号
    @State private var train_seatNumberIn: String //座位号
    
    @State private var train_typeIn: String //列车类型
    @State private var train_vehicleNumberIn: String //列车编号
    @State private var train_statusIn: String //准点/晚点
    
    @State private var train_commentIn: String//评价记录
    
    init(train: TrainStorage) {
        self.train = train
        
        _train_countryIn = State(initialValue: train.train_country)
        _train_operationCompanyIn = State(initialValue: train.train_operationCompany)
        _train_classIn = State(initialValue: train.train_class)
        _train_numberIn = State(initialValue: train.train_number)
        _train_startCountryIn = State(initialValue: train.train_startCountry)
        _train_startCityIn = State(initialValue: train.train_startCity)
        _train_startStationIn = State(initialValue: train.train_startStation)
        _train_arriveCountryIn = State(initialValue: train.train_arriveCountry)
        _train_arriveCityIn = State(initialValue: train.train_arriveCity)
        _train_arriveStationIn = State(initialValue: train.train_arriveStation)
        _train_startDateIn = State(initialValue: train.train_startDate)
        _train_arriveDateIn = State(initialValue: train.train_arriveDate)
        _train_seatCarNumberIn = State(initialValue: train.train_seatCarNumber)
        _train_seatNumberIn = State(initialValue: train.train_seatNumber)
        
        _train_typeIn = State(initialValue: train.train_type)
        _train_vehicleNumberIn = State(initialValue: train.train_vehicleNumber)
        _train_statusIn = State(initialValue: train.train_status)
        
        _train_commentIn = State(initialValue: train.train_comment)
    }
    
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
    
    var body: some View{
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
                        updateTrainTrip()
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
        .navigationTitle("Edit the Train Trip")
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
    
    //更新
    func updateTrainTrip(){
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
        
        train.train_country = train_countryIn
        train.train_operationCompany = train_operationCompanyIn
        train.train_class = train_classIn
        train.train_number = train_numberIn
        train.train_startCountry = train_startCountryIn
        train.train_startCity = train_startCityIn
        train.train_startStation = train_startStationIn
        train.train_arriveCountry = train_arriveCountryIn
        train.train_arriveCity = train_arriveCityIn
        train.train_arriveStation = train_arriveStationIn
        train.train_startDate = train_startDateIn
        train.train_arriveDate = train_arriveDateIn
        train.train_seatCarNumber = train_seatCarNumberIn
        train.train_seatNumber = train_seatNumberIn
        train.train_type = train_typeIn
        train.train_vehicleNumber = train_vehicleNumberIn
        train.train_status = train_statusIn
        train.train_comment = train_commentIn
        
        showSuccessAlert = true
        dismiss()
    }
    
    func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}

#Preview {
    TrainEditView(train: TrainStorage())
}
