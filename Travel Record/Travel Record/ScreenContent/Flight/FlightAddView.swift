//
//  FlightAddView.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/14/26.
//

import SwiftUI
import SwiftData


struct FlightAddView: View {
    @State var AirlineIn: String = ""
    @State var numberIn: Int = 0
    @State var DEPIn = ""//起飞地
    @State var ARRIn = ""//降落地
    @State var DEP_TimeIn = Date()//DATE
    @State var ARR_TimeIn = Date()//DATE
    @State var SeatIn = ""
    @State var ClassIn = ""
    @State var DEP_TerminalIn = ""
    @State var ARR_TerminalIn = ""
    @State var BoardGateIn = ""
    @State var StatusIn = ""
    
    @State var AircraftIn = ""
    @State var RegNumberIn = ""
    
    @State var flight_comment = ""
    
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
    @Environment(\.dismiss) var dismiss
    
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
                    Text("Number:")
                    TextField("", value: $numberIn, format:.number.grouping(.never))//输入航班编号
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
                    Text("Arrival Terminal:")
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
                    Text("Board Gate:")
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
                    Text("Reg Number:")
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
                        createNewFlight()
                    } label: {
                        Text("Confirm")
                    }
                }
                .padding()

                // 成功提示
                .alert("Success", isPresented: $showSuccessAlert) {
                    Button("OK") {
                        dismiss()
                    }
                } message: {
                    Text("Flight has been added successfully.")
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
        .navigationTitle("Add a New Flight")
        
    }
    
    //新建
    func createNewFlight() {
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
        let newFlight = FlightStorage(
            airline: airline,
            number: numberIn,
            DEP: dep,
            ARR: arr,
            DEP_Time: DEP_TimeIn,
            ARR_Time: ARR_TimeIn,
            Seat: SeatIn,
            Class: ClassIn,
            DEP_Terminal: DEP_TerminalIn,
            ARR_Terminal: ARR_TerminalIn,
            BoardGate: BoardGateIn,
            Status: StatusIn,
            Aircraft: AircraftIn,
            RegNumber: RegNumberIn,
            flight_comment: flight_comment
        )

        modelContext.insert(newFlight)
        showSuccessAlert = true
    }

    func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}
    
#Preview {
    FlightAddView()
}
