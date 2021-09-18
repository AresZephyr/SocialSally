//
//  SocialSallyApp.swift
//  SocialSally
//
//  Created by Eddie Gear on 10/09/2019.
//  Copyright © 2021 Weekend Launchpad. All rights reserved.
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
