//
//  SocialSallyApp.swift
//  SocialSally
//
//  Created by Eddie Gear on 16/09/21.
//

import SwiftUI

@main
struct SocialSallyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
