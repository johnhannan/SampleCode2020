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
    
    init() {
        
        let filename = "StateData"
        let mainBundle = Bundle.main
        let jsonURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            allStates = try decoder.decode(AllStates.self, from: data)
        } catch  {
           print("Error info: \(error)")
            allStates = []
        }
      
        
    }
}
