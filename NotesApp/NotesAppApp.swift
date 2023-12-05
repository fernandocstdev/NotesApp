//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by Fernando Dorantes on 04/12/23.
//

import SwiftUI

@main
struct NotesAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
