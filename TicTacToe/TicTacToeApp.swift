//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Dominik on 27/05/2025.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    @Environment(\.managedObjectContext) var managedObjectContext
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
