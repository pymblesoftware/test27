//
//  test27App.swift
//  test27
//
//  Created by Regan Russell on 4/3/2025.
//
// 1. Never once won work after doing a coding test and I have had over 100 jobs in 35 years
// (  https://www.amazon.com.au/gp/aw/d/B0DP7CR7SV/ref=tmm_pap_swatch_0?ie=UTF8&qid=&sr=  )
//
///2.   Never gained anything from those work for sweat equity jobs.
//
// 3. Don't even have a properly functioning development system
//
// 4. Will not work for free nor do extensive programming tests or the like.
//
//
// 

import SwiftUI
import SwiftData

@main
struct test27App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
