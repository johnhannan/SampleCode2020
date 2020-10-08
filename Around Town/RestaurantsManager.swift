//
//  RestaurantsManager.swift
//  Around Town
//
//  Created by jjh9 on 10/7/20.
//

import Foundation

struct Restaurant : Codable {
    var name : String
    var address : String
}

class RestaurantsManager {
    let restaurants : [Restaurant]
    
    init() {
        let restaurantURL = Bundle.main.url(forResource: "Restaurants", withExtension: "json")!
        do {
            let data = try Data(contentsOf: restaurantURL)
            let decoder = JSONDecoder()
            restaurants = try decoder.decode([Restaurant].self, from: data)
        } catch   {
            print("Error decoding Restaurants: \(error)")
            restaurants = []
        }
    }
}
