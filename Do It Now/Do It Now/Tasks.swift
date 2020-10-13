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
    func addItem(item:String) {
        items.append(item)
    }
    
    func deleteItems(indexSet:IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItems(offsets:IndexSet, to index:Int) {
        items.move(fromOffsets: offsets, toOffset: index)
    }
    
    func save() {
        taskManager.saveItems(items)
    }
    
}
