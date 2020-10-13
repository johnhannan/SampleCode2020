//
//  StorageModel.swift
//  Footballers
//
//  Created by jjh9 on 10/6/20.
//

import Foundation

class StorageModel {
    private let destinationURL : URL
    var footballers : [Player]
    var teams : [Team]
    
    init() {
        let filename = "footballers"
        
        let mainBundle = Bundle.main
        let playerURL = mainBundle.url(forResource: filename, withExtension: "json")
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL =  documentURL.appendingPathComponent(filename + ".json")
        
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        let url =  fileExists ? destinationURL : playerURL

            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: url!)
                footballers = try decoder.decode(Players.self, from: data)
            } catch {
                print(error)
                footballers = []
            }
        
        //compute teams
        var _teams = [Team]()
        /* TODO: Compute array of Teams */
        teams = _teams
    }
    
    //MARK: - Saving Data
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(footballers)
            try data.write(to: destinationURL)
        } catch {
            print("Error writing data")
        }
    }
}
