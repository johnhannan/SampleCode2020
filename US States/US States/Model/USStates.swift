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
    var centuryFounded: Int { year/100 }
    var decadeFounded : Int { year/10*10}
}

typealias AllStates = [USState]

struct USStates  {
    var  allStates : AllStates
    
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
    
    var centuries: [Int] {
        let allCenturies = allStates.map({ $0.centuryFounded })
        let duplicatesRemoved = Array(Set(allCenturies))
        return duplicatesRemoved.sorted()
    }
    
    // the ordered list of all the titles for states given by the property
    // the property returns the title for a state
    func stateTitles(for titleFor: (USState) -> String) -> [String] {
        let titles = Set(allStates.map(titleFor))
        return titles.sorted()
    }
    
    // the list of indices for all the staters satisfying the given property
    func indices(for property: (USState) -> Bool) -> [Int] {
        let filteredStates = allStates.filter(property)
        let indices = filteredStates.map {s in allStates.firstIndex(where: {$0.name == s.name})!}
        return indices
    }
    
}
