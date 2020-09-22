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
}

typealias AllStates = [USState]

struct USStates  {
    var  allStates : AllStates
    //var  statesByInitial : [String:AllStates]
    
    init() {
        let filename = "StateData"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        
        do {
            let data = try Data(contentsOf: bundleURL)
            let decoder = JSONDecoder()
            allStates = try decoder.decode(AllStates.self, from: data)
        } catch  {
            print("Error info: \(error)")
            allStates = []
        }
        
    }
    
    
    
    func sectionTitles(for property: (USState) -> String) -> [String] {
        let titles = Set(allStates.map(property))
        return titles.sorted()
        
    }
    
    func indices(for property: (USState) -> Bool) -> [Int] {
        let filteredStates = allStates.filter(property)
        let indices = filteredStates.map {s in allStates.firstIndex(where: {$0.name == s.name})!}
        return indices
    }
    
}
