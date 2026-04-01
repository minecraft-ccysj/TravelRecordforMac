//
//  FlightShowView.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/13/26.
//

import SwiftUI
import SwiftData
import Combine

struct FlightShowView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(
        sort: [SortDescriptor(\FlightStorage.DEP_Time, order: .reverse)]
    )
    private var flights: [FlightStorage]
    
    @State private var flightToDelete: FlightStorage?
    @State private var selectedFlight: FlightStorage?
    
    // --- 新增：用于自动刷新的状态 ---
    @State private var now = Date()
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    // 修改：让过滤逻辑依赖于变量 'now'
    private var upcomingFlights: [FlightStorage] {
        // 如果你希望“当天”都算 Upcoming，请改回 Calendar.current.startOfDay(for: now)
        // 这里使用 now 是为了让过时的航班（如2:30起飞，现在2:31）立即移动到历史
        flights.filter { $0.DEP_Time >= now }
    }
    
    private var historyFlights: [FlightStorage] {
        flights.filter { $0.DEP_Time < now }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Upcoming Flights") {
                    if upcomingFlights.isEmpty {
                        Text("No upcoming flights")
                            .foregroundStyle(.secondary)
                    }
                    ForEach(upcomingFlights) { flight in
                        flightCard(flight)
                    }
                }
                
                Section("Flight History") {
                    if historyFlights.isEmpty {
                        Text("No flight history")
                            .foregroundStyle(.secondary)
                    }
                    ForEach(historyFlights) { flight in
                        flightCard(flight)
                    }
                }
            }
            .navigationTitle("My Flight")
            .toolbar {
                NavigationLink(destination: FlightAddView()) {
                    Image(systemName: "plus")
                }
            }
            .navigationDestination(item: $selectedFlight) { flight in
                FlightDetailView(flight: flight)
            }
            // --- 关键：每分钟更新一次 now，触发视图重绘 ---
            .onReceive(timer) { input in
                now = input
            }
        }
    }
}

extension FlightShowView {
    private func flightCard(_ flight: FlightStorage) -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(flight.DEP)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(flight.DEP_Time, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            VStack(spacing: 6) {
                Text(flight.airline + String(flight.number))
                    .foregroundColor(.blue)
                    .font(.headline)
                HStack(spacing: 6) {
                    Rectangle().frame(height: 1).foregroundStyle(.secondary)
                    Image(systemName: "airplane").font(.caption)
                    Rectangle().frame(height: 1).foregroundStyle(.secondary)
                }
                Text(flight.Status).font(.caption).foregroundStyle(.secondary)
            }
            .frame(width: 160)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(flight.ARR)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(flight.ARR_Time, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 100, alignment: .trailing)
            
            Spacer()
            
            //删除+信息
            VStack(spacing: 10) {
                Button { selectedFlight = flight } label: {
                    Image(systemName: "info.circle")
                }
                Button { flightToDelete = flight } label: {
                    Image(systemName: "trash").foregroundColor(.red)
                }
            }
            .frame(width: 40)
        }
        .padding(.vertical, 8)
        .alert("Delete Flight?", isPresented: .init(
            get: { flightToDelete == flight },
            set: { if !$0 { flightToDelete = nil } }
        )) {
            Button("Delete", role: .destructive) {
                if let flightToDelete {
                    modelContext.delete(flightToDelete)
                }
                self.flightToDelete = nil
            }
            Button("Cancel", role: .cancel) { flightToDelete = nil }
        } message: {
            Text("Are you sure you want to delete?\n(This action cannot be undone.)")
        }
    }
}

#Preview {
    FlightShowView()
}
