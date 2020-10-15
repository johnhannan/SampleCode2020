//
//  PlayerModel.swift
//  Footballers
//
//  Created by John Hannan on 10/28/19.
//  Copyright © 2019 John Hannan. All rights reserved.
//

import Foundation
typealias Players = [Player]



class PlayersModel : ObservableObject {
    let storageModel : StorageModel

    @Published var footballers : Players
    @Published var teams : [Team]
    
    init() {
       let _storageModel = StorageModel()
        footballers = _storageModel.footballers
        teams = _storageModel.teams
        storageModel = _storageModel
    }
    

    func addPlayer(player:Player) {
        footballers.append(player)
    }
    
    //MARK: - Saving Data
    func saveData() {
        storageModel.saveData()
    }
    

}
