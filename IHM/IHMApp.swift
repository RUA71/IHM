//
//  IHMApp.swift
//  IHM
//
//  Created by Andrea on 15/06/2026.
//

import SwiftUI
import SwiftData

@main
struct IHMApp: App {
    @StateObject private var authVM    = AuthViewModel()
    @StateObject private var eventsVM  = EventsViewModel()
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(eventsVM)
        }
        // .modelContainer(sharedModelContainer)
    }
}
