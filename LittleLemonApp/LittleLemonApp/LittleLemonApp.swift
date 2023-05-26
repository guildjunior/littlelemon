//
//  LittleLemonAppApp.swift
//  LittleLemonApp
//
//  Created by Guild Junior on 24/05/23.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Onboarding().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
