//
//  ContentView.swift
//  Travel Record
//
//  Created by Christophe Lee on 11/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // 定义一个状态变量来跟踪当前选中的项目
    @State private var selectedSidebarItem: Int?

    // 定义一个数组来存储不同的视图
    let ScreenView: [AnyView] = [
        AnyView(WelcomeView()),
        AnyView(
            NavigationStack {
                FlightShowView()
            }
        ),
        AnyView(
            NavigationStack{
                TrainShowView()
            }
        )
    ]

    var body: some View {
        NavigationSplitView {
            // Sidebar 内容
            List {
                // 每个导航项点击时更新 selectedSidebarItem
                NavigationLink(value: 1){
                    Label("Profile", systemImage: "person.crop.circle")
                }
                NavigationLink(value: 2){
                    Label("Flight", systemImage: "airplane")
                }
                NavigationLink(value: 3){
                    Label("Train", systemImage: "train.side.front.car")
                }
            }
            .navigationDestination(for: Int.self) { item in
                // 根据选中的项目更新 detail 内容
                ScreenView[item - 1] // 数组索引从0开始，而value从1开始
            }
        } detail: {
            // 根据 selectedSidebarItem 显示对应的 detail 内容
            if let selectedSidebarItem = selectedSidebarItem {
                ScreenView[selectedSidebarItem - 1] // 数组索引从0开始，而value从1开始
            } else {
                // 如果没有选中任何项目，显示默认内容
                AnyView(WelcomeView())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



#Preview {
    ContentView()
        .modelContainer(for: FlightStorage.self, inMemory: true)
}
