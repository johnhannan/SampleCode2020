//
//  FootballersApp.swift
//  Footballers
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

@main
struct FootballersApp: App {
    let playersModel = PlayersModel()
    let persistenceController = PersistenceController.shared
    
    
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(playersModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) {phase in
            switch phase {
            case .inactive:
                playersModel.saveData()
                try? persistenceController.container.viewContext.save()
            default:
                break
            }
        }
    }
}
