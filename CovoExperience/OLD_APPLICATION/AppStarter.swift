//
//  CovoExperienceApp.swift
//  CovoExperience
//
//  Created by Antonio Giordano on 27/05/24.
//

import SwiftUI
import SwiftData

@main
struct AppStarter: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            //Item.self,
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
            homepage()
        }
        .modelContainer(sharedModelContainer)
    }
}
