//
//  USStates.swift
//  US States
//
//  Created by jjh9 on 9/15/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation

struct USState : Codable {
    let name : String
    let capital : String
    let info : String
    let year : Int
    var favorite : Bool
    let visited : Bool
    let images : [String]
    
    enum CodingKeys : String, CodingKey {
        case name = "state"
        case capital
        case info
        case year
        case favorite
        case visited
        case images
    }
    
    var image : String { images.count > 0 ? images[0] : name }
    var centuryAdmitted: Int { year/100 }
    var decadeAdmitted : Int { year/10*10}
}

typealias AllStates = [USState]

struct USStates  {
    var  allStates : AllStates {
        didSet {
            saveData()
        }
    }
    
    let destinationURL : URL
    
    init() {
        let filename = "StateData"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        
        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            allStates = try decoder.decode(AllStates.self, from: data)
        } catch  {
            print("Error info: \(error)")
            allStates = []
        }
        
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data  = try encoder.encode(allStates)
            try data.write(to: self.destinationURL)
        } catch  {
            print("Error writing: \(error)")
        }
    }
    
    var centuries: [Int] {
        let allCenturies = Set(allStates.map({ $0.centuryAdmitted }))
        return allCenturies.sorted()
    }
    

    func stateTitles(using titleFor: (USState) -> String) -> [String] {
        let titles = Set(allStates.map(titleFor))
        return titles.sorted()
    }
    

    func stateIndices(for property: (USState) -> Bool) -> [Int] {
        let filteredStates = allStates.filter(property)
        let indices = filteredStates.map {s in allStates.firstIndex(where: {$0.name == s.name})!}
        return indices
    }
    
}











// the ordered list of all the titles for states given by the property
// the property returns the title for a state
// the list of indices for all the staters satisfying the given property

