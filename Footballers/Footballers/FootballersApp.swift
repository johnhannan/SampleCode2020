//
//  FootballersApp.swift
//  Footballers
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

@main
struct FootballersApp: App {
    let playerModel = PlayersModel()
    
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(playerModel)
        }
        .onChange(of: scenePhase) {phase in
            switch phase {
            case .inactive:
                playerModel.saveData()
            default:
                break
            }
        }
    }
}
