//
//  Travel_RecordApp.swift
//  Travel Record
//
//  Created by Christophe Lee on 11/19/25.
//

import SwiftUI
import SwiftData

@main
struct Travel_RecordApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FlightStorage.self,
            TrainStorage.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
