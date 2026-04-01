//
//  TrainDetailView.swift
//  Travel Record
//
//  Created by Christophe Lee on 3/11/26.
//

import SwiftUI
import SwiftData

struct TrainDetailView: View {
    @Environment(\.dismiss) var dismiss
    let train: TrainStorage

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 基本信息：车次与运营公司
                VStack(alignment: .leading) {
                    Text("\(train.train_number)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.orange)
                    Text(train.train_operationCompany)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                Divider()

                // 行程信息
                HStack {
                    VStack(alignment: .leading) {
                        Text("Departure").font(.caption).foregroundColor(.secondary)
                        Text(train.train_startCity).font(.title2).bold()
                        Text(train.train_startStation).font(.subheadline)
                        Text(train.train_startDate, style: .date)
                        Text(train.train_startDate, style: .time)
                    }
                    
                    Spacer()
                    Image(systemName: "train.side.front.car")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("Arrival").font(.caption).foregroundColor(.secondary)
                        Text(train.train_arriveCity).font(.title2).bold()
                        Text(train.train_arriveStation).font(.subheadline)
                        Text(train.train_arriveDate, style: .date)
                        Text(train.train_arriveDate, style: .time)
                    }
                }

                Divider()

                // 座位与车辆信息
                Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
                    GridRow {
                        DetailItem(label: "Class", value: train.train_class)
                        DetailItem(label: "Status", value: train.train_status)
                    }
                    GridRow {
                        DetailItem(label: "Car", value: train.train_seatCarNumber)
                        DetailItem(label: "Seat", value: train.train_seatNumber)
                    }
                    GridRow {
                        DetailItem(label: "Type", value: train.train_type)
                        DetailItem(label: "Vehicle #", value: train.train_vehicleNumber)
                    }
                }

                if !train.train_comment.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Comment").font(.headline)
                        Text(train.train_comment)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            
        }
        .navigationTitle("Train Detail")
        .toolbar{
            NavigationLink(destination: TrainEditView(train:train)){
                Image(systemName: "pencil")
            }
        }
    }
    
}

// 辅助组件
struct DetailItem: View {
    let label: String
    let value: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.caption).foregroundColor(.secondary)
            Text(value.isEmpty ? "N/A" : value).font(.body)
        }
    }
}


#Preview {
    TrainDetailView(train: TrainStorage(train_number: "G123"))
}
