//
//  TaskManager.swift
//  Do It Now
//
//  Created by jjh9 on 10/11/20.
//

import Foundation

struct TaskManager {
    private let filename = "DoItNow"
    private let destinationURL : URL
    typealias ItemData = [String]
    let items : ItemData
    
    init() {
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        
        if fileExists {
            do {
                let data = try Data(contentsOf: destinationURL)
                let decoder = JSONDecoder()
                items = try decoder.decode([String].self, from: data)
            } catch  {
                print("Error info: \(error)")
                items = []
            }
        } else {
            items = ["Walk my dog", "Have a snack", "Prepare for class", "Take a nap"]
        }
        
    }
    
    func saveItems(_ items:ItemData) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            try data.write(to: destinationURL)
        } catch  {
            print("Error info: \(error)")
        }
    }
    
    
    
    
}
