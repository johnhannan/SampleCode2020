//
//  Tasks.swift
//  Do It Now
//
//  Created by jjh9 on 10/11/20.
//

import Foundation

class Tasks : ObservableObject {
    let taskManager : TaskManager
    @Published var items : [String]
    
    init() {
        taskManager = TaskManager()
        items = taskManager.items
    }
    
    func save() {
        taskManager.saveItems(items)
    }
    
}
