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
    
    //MARK: filtering
    func playerIndicesFilteredBy(searchText:String) -> [Int] {
        let filteredPlayers = footballers.filter({$0.lastname.hasPrefix(searchText)})
        let indices = filteredPlayers.map {fp in footballers.firstIndex(where: {$0.fullname == fp.fullname})!}
        return indices
    }
    func playerIndicesFor(players:[Player]) -> [Int] {
        let indices = players.map {fp in footballers.firstIndex(where: {$0.fullname == fp.fullname})!}
        return indices
    }
    
    
    
    //MARK: - Saving Data
    func saveData() {
        storageModel.saveData()
    }
    

}
