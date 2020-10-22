//
//  Do_It_NowApp.swift
//  Do It Now
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

@main
struct Do_It_NowApp: App {
    let persistenceController = PersistenceController.shared

    
    @StateObject var tasks = Tasks()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TaskMOListView()
                .environmentObject(tasks)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }.onChange(of: scenePhase) { (phase) in
            switch phase {
            case .inactive:
                tasks.save()
                try? persistenceController.container.viewContext.save()
            default:
                break
            }
        }
    }
}
