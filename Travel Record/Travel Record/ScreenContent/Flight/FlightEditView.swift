//
//  FlightEditView.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/30/26.
//

import SwiftUI
import SwiftData


struct FlightEditView: View {
    
    @Bindable var flight: FlightStorage

    @Environment(\.dismiss) var dismiss
    
    @State private var AirlineIn: String
    @State private var numberIn: Int
    @State private var DEPIn: String
    @State private var ARRIn: String
    @State private var DEP_TimeIn: Date
    @State private var ARR_TimeIn: Date
    @State private var SeatIn: String
    @State private var ClassIn: String
    @State private var DEP_TerminalIn: String
    @State private var ARR_TerminalIn: String
    @State private var BoardGateIn: String
    @State private var StatusIn: String
    @State private var AircraftIn: String
    @State private var RegNumberIn: String
    @State private var flight_comment: String
    
    init(flight: FlightStorage) {
        self.flight = flight

        _AirlineIn = State(initialValue: flight.airline)
        _numberIn = State(initialValue: flight.number)
        _DEPIn = State(initialValue: flight.DEP)
        _ARRIn = State(initialValue: flight.ARR)
        _DEP_TimeIn = State(initialValue: flight.DEP_Time)
        _ARR_TimeIn = State(initialValue: flight.ARR_Time)
        _SeatIn = State(initialValue: flight.Seat)
        _ClassIn = State(initialValue: flight.Class)
        _DEP_TerminalIn = State(initialValue: flight.DEP_Terminal)
        _ARR_TerminalIn = State(initialValue: flight.ARR_Terminal)
        _BoardGateIn = State(initialValue: flight.BoardGate)
        _StatusIn = State(initialValue: flight.Status)
        _AircraftIn = State(initialValue: flight.Aircraft)
        _RegNumberIn = State(initialValue: flight.RegNumber)
        _flight_comment = State(initialValue: flight.flight_comment)
    }

    
    @State private var showSuccessAlert = false
    
    @State private var depTimeZoneID = TimeZone.current.identifier
    @State private var arrTimeZoneID = TimeZone.current.identifier

    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    private let commentLimit = 100//字数限制
    
    private var commentColor: Color {
        if flight_comment.count >= commentLimit {
            return .red
        } else if flight_comment.count > commentLimit * 9 / 10 {
            return .orange
        } else {
            return .secondary
        }
    }

    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
            ScrollView(){//TODO，仅仅是外观布局，无大用
                VStack(alignment:.leading){
                    Text("Passenger Information")
                        .font(.title)
                        .padding()
                    HStack{//输入Airline
                        Text("Airline:")
                        TextField("", text: $AirlineIn)//输入航司
                            .frame(width: 70)
                        Spacer()
                        Text("Number")
                        TextField("", value: $numberIn, format:.number)//输入航班编号
                            .frame(width: 100)
                    }
                    .padding()
                    HStack{//起降地
                        Text("Departure:")
                        TextField("", text: $DEPIn)
                            .frame(width: 200)
                            .onChange(of: DEPIn){
                                depTimeZoneID = TimeZoneChart.timeZoneID(for: DEPIn)
                            }
                        Spacer()
                        Text("Arrive:")
                        TextField("", text: $ARRIn)
                            .frame(width: 200)
                            .onChange(of: ARRIn){
                                arrTimeZoneID = TimeZoneChart.timeZoneID(for: ARRIn)
                            }
                    }
                    .padding()
                    HStack{//时间
                        DatePicker(selection: $DEP_TimeIn, label: { Text("Predict DEP Time") })
                        Spacer()
                        DatePicker(selection: $ARR_TimeIn, label:{ Text("Predict ARR Time")})
                    }
                    .padding()
                    HStack{
                        Text("Departure Terminal:")
                        TextField("", text: $DEP_TerminalIn)
                            .frame(width: 50)
                        Spacer()
                        Text("Arrive Terminal:")
                        TextField("", text: $ARR_TerminalIn)
                            .frame(width: 50)
                    }
                    .padding()
                    HStack{
                        Text("Seat:")
                        TextField("",text: $SeatIn)
                            .frame(width: 50)
                        Spacer()
                        Picker("Class:", selection: $ClassIn){
                            Text("First").tag("First")
                            Text("Business").tag("Business")
                            Text("Premium Economy").tag("Premium Economy")
                            Text("Economy").tag("Economy")
                        }
                        Spacer()
                        Text("Board Gate")
                        TextField("", text: $BoardGateIn)
                            .frame(width: 70)
                    }
                    .padding()
                    Text("Aircraft Information")
                        .font(.title)
                        .padding()
                    HStack{
                        Picker("Status:", selection: $StatusIn){
                            Text("Early").tag("Early")
                            Text("Normal").tag("Normal")
                            Text("Late").tag("Late")
                            Text("Canecl").tag("Cancel")
                        }
                        Spacer()
                        Text("Aircraft:")
                        TextField("", text: $AircraftIn)
                            .frame(width: 100)
                        Spacer()
                        Text("Reg Number")
                        TextField("", text: $RegNumberIn)
                            .frame(width: 100)
                    }
                    .padding()
                    Text("Personal Infomation")//写用户评论
                        .font(.title)
                        .padding()
                    VStack(alignment: .leading){
                        HStack{
                            Text("Write comment here:")
                        }
                        ZStack(alignment: .topLeading) {
                            if flight_comment.isEmpty {
                                Text("Any notes about this flight...")
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                                    .padding(.leading, 6)
                            }

                            TextEditor(text: $flight_comment)
                                .frame(height: 60)
                                .padding(4)
                                .onChange(of: flight_comment) { _, newValue in
                                    if newValue.count > commentLimit {
                                        flight_comment = String(newValue.prefix(commentLimit))
                                    }
                                }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray.opacity(0.4))
                        )
                        HStack {
                            Spacer()
                            Text("\(flight_comment.count) / \(commentLimit)")
                                .font(.caption)
                                .foregroundColor(commentColor)
                        }
                    }
                    .padding()
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }

                        Button {
                            updateFlight()
                        } label: {
                            Text("Save")
                        }
                    }
                    .padding()

                    // 成功提示
                    .alert("Success", isPresented: $showSuccessAlert) {
                        Button("OK") {
                            dismiss()
                        }
                    } message: {
                        Text("Flight has been edited successfully.")
                    }

                    // 错误提示
                    .alert("Incomplete Information", isPresented: $showErrorAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text(errorMessage)
                    }

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Edit the Flight")
        
    }
    
    //更新
    func updateFlight() {
        // 1️⃣ 去掉前后空格，防止用户输入空格
        let airline = AirlineIn.trimmingCharacters(in: .whitespacesAndNewlines)
        let dep = DEPIn.trimmingCharacters(in: .whitespacesAndNewlines)
        let arr = ARRIn.trimmingCharacters(in: .whitespacesAndNewlines)

        // 2️⃣ 基本完整性检查
        guard !airline.isEmpty else {
            showError("Please enter airline.")
            return
        }

        guard numberIn > 0 else {
            showError("Please enter a valid flight number.")
            return
        }

        guard !dep.isEmpty else {
            showError("Please enter departure airport.")
            return
        }

        guard !arr.isEmpty else {
            showError("Please enter arrival airport.")
            return
        }

        // 3️⃣ 所有检查通过，保存
        flight.airline = AirlineIn
        flight.number = numberIn
        flight.DEP = DEPIn
        flight.ARR = ARRIn
        flight.DEP_Time = DEP_TimeIn
        flight.ARR_Time = ARR_TimeIn
        flight.Seat = SeatIn
        flight.Class = ClassIn
        flight.DEP_Terminal = DEP_TerminalIn
        flight.ARR_Terminal = ARR_TerminalIn
        flight.BoardGate = BoardGateIn
        flight.Status = StatusIn
        flight.Aircraft = AircraftIn
        flight.RegNumber = RegNumberIn
        flight.flight_comment = flight_comment

        showSuccessAlert = true
        
        dismiss()
    }

    func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}
    
#Preview {
    FlightAddView()
}
