//
//  Do_It_NowApp.swift
//  Do It Now
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

@main
struct Do_It_NowApp: App {
    let tasks = Tasks()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environmentObject(tasks)
        }.onChange(of: scenePhase) { (phase) in
            switch phase {
            case .inactive:
                tasks.save()
            default:
                break
            }
        }
    }
}
