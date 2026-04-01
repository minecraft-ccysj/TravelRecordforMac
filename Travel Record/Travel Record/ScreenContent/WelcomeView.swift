//
//  Welcome.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/13/26.
//

import SwiftUI
import SwiftData

struct WelcomeView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 20){//welcome界面
            HStack{//用户信息显示（头像）（用户名）
                Image(systemName:"person.crop.circle")//TODO头像
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("USER")//TODO用户名
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            Text("Scheduled Flight")
                .padding()
            HStack{//TODO如果有就显示航班/铁路，没有显示no scheduled Trip
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            Text("Flight Statistics")
                .padding()
            HStack{//TODO统计飞行次数
                    
            }
            .padding()
                
        }
        .navigationTitle("Profile")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}



#Preview {
    ContentView()
        .modelContainer(for: FlightStorage.self, inMemory: true)
}
