//
//  TrainShowView.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/26/26.
//

import SwiftUI
import SwiftData
import Combine

struct TrainShowView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\TrainStorage.train_startDate, order: .reverse)])
    private var allTrains: [TrainStorage]
    
    @State private var trainToDelete: TrainStorage?
    @State private var selectedTrain: TrainStorage?
    
    // --- 新增：自动刷新逻辑 ---
    @State private var now = Date()
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    private var upcomingTrains: [TrainStorage] {
        allTrains.filter { $0.train_startDate >= now }
    }
    
    private var historyTrains: [TrainStorage] {
        allTrains.filter { $0.train_startDate < now }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Upcoming Train Trips") {
                    if upcomingTrains.isEmpty {
                        Text("No upcoming trips").foregroundStyle(.secondary)
                    } else {
                        ForEach(upcomingTrains) { train in
                            trainsCard(train)
                        }
                    }
                }
                
                Section("Train Trips History") {
                    if historyTrains.isEmpty {
                        Text("No trip history").foregroundStyle(.secondary)
                    } else {
                        ForEach(historyTrains) { train in
                            trainsCard(train)
                        }
                    }
                }
            }
            .navigationTitle("My Train Trips")
            .toolbar {
                NavigationLink(destination: TrainAddView()) {
                    Image(systemName: "plus")
                }
            }
            .navigationDestination(item: $selectedTrain) { train in
                TrainDetailView(train: train)
            }
            // --- 接收定时器，更新时间 ---
            .onReceive(timer) { input in
                now = input
            }
        }
    }
}

extension TrainShowView {
    @ViewBuilder
    private func trainsCard(_ train: TrainStorage) -> some View {
        HStack(alignment: .center, spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text(train.train_startCity).font(.title2).fontWeight(.bold)
                Text(train.train_startStation).font(.caption).lineLimit(1).foregroundStyle(.secondary)
                Text(train.train_startDate, style: .date).font(.caption).foregroundStyle(.secondary)
            }
            .frame(width: 90, alignment: .leading)
            
            Spacer()
            
            VStack(spacing: 6) {
                Text(train.train_number).font(.headline).foregroundColor(.orange)
                HStack(spacing: 6) {
                    Rectangle().frame(height: 1).foregroundStyle(.secondary.opacity(0.3))
                    Image(systemName: "train.side.front.car").font(.caption).foregroundColor(.secondary)
                    Rectangle().frame(height: 1).foregroundStyle(.secondary.opacity(0.3))
                }
                Text(train.train_status).font(.caption2).foregroundStyle(.secondary)
            }
            .frame(width: 120)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(train.train_arriveCity).font(.title2).fontWeight(.bold)
                Text(train.train_arriveStation).font(.caption).lineLimit(1).foregroundStyle(.secondary)
                Text(train.train_arriveDate, style: .date).font(.caption).foregroundStyle(.secondary)
            }
            .frame(width: 90, alignment: .trailing)
            
            Spacer()
            
            //删除+信息
            VStack(spacing: 15) {
                Button { selectedTrain = train } label: {
                    Image(systemName: "info.circle")
                }
                Button { trainToDelete = train } label: {
                    Image(systemName: "trash").foregroundColor(.red)
                }
            }
            .frame(width: 40)
        }
        .padding(.vertical, 8)
        .alert("Delete Trip?", isPresented: .init(
            get: { trainToDelete == train },
            set: { if !$0 { trainToDelete = nil } }
        )) {
            Button("Delete", role: .destructive) {
                modelContext.delete(train)
                trainToDelete = nil
            }
            Button("Cancel", role: .cancel) { trainToDelete = nil }
        } message: {
            Text("Are you sure you want to delete this train record?")
        }
    }
}

#Preview {
    TrainShowView()
        .modelContainer(for: TrainStorage.self, inMemory: true)
}
