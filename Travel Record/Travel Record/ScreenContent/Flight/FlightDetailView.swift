//
//  FlightDetailView.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/29/26.
//

import SwiftUI
import SwiftData

struct FlightDetailView: View {
    
    @Environment(\.dismiss) var dismiss

    let flight: FlightStorage

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {

                // 基本信息
                Text("\(flight.airline) \(String(flight.number))")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .bold()
                Spacer()
                HStack {//出发
                    VStack(alignment: .leading) {
                        Text("Departure")
                            .font(.title2)
                        Spacer()
                        HStack{//出发地+航站楼
                            Text(flight.DEP)
                                .font(.title)
                                .fontWeight(.heavy)
                            Text(flight.DEP_Terminal)
                                .font(.title)
                                .fontWeight(.heavy)
                        }
                        Text(flight.DEP_Time, style: .date)
                        Spacer()
                        Text(flight.DEP_Time, style: .time)
                    }

                    Spacer()

                    VStack(alignment: .leading) {//到达
                        Text("Arrival")
                            .font(.title2)
                        Spacer()
                            .foregroundStyle(.secondary)
                        HStack{
                            Text(flight.ARR)
                                .font(.title)
                                .fontWeight(.heavy)
                            Text(flight.ARR_Terminal)
                                .font(.title)
                                .fontWeight(.heavy)
                        }
                        Spacer()
                        Text(flight.ARR_Time, style: .date)
                        Spacer()
                        Text(flight.ARR_Time, style: .time)
                    }
                }


                Divider()

                // 航班状态
                Group {
                    Text("Status: \(flight.Status)")
                    Spacer()
                    Text("Seat: \(flight.Seat)")
                    Spacer()
                    Text("Class: \(flight.Class)")
                    Spacer()
                    Text("DEP Terminal: \(flight.DEP_Terminal)")
                    Text("ARR Terminal: \(flight.ARR_Terminal)")
                    Spacer()
                    Text("Board Gate: \(flight.BoardGate)")
                }

                Divider()

                // 飞机信息
                Group {
                    Text("Aircraft: \(flight.Aircraft)")
                    Spacer()
                    Text("Registration: \(flight.RegNumber)")
                }

                Divider()

                // 评论
                if !flight.flight_comment.isEmpty {
                    Text("Comment")
                        .font(.headline)
                    Text(flight.flight_comment)
                        .padding()
                }
            }
            .padding()
            
        }
        .navigationTitle("Flight Detail")
        .toolbar {
            NavigationLink(destination: FlightEditView(flight: flight)) {
                Image(systemName: "pencil")
            }
        }
        
    }
}

#Preview {
    // 仅用于预览
    FlightDetailView(flight: FlightStorage(number: 123))
}

