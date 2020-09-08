//
//  GameModel.swift
//  Memory
//
//  Created by jjh9 on 9/8/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation

enum GameState {
    case notPlaying, memorizing, guessing, lost, won
}

class GameModel : ObservableObject {
    
    var itemCount : Int
    
    init(with count:Int) {
        itemCount = count
    }
    
    @Published var gameState : GameState = .notPlaying
    var sequence : [Int] = []
    let sequenceLength = 4
    
    @Published var nextGuessIndex = 0
    
    func resetGame() {
        nextGuessIndex = 0
        
        sequence.removeAll()
        for _ in (0..<sequenceLength) {
            let randomIndex = Int.random(in: 0..<itemCount)
            sequence.append(randomIndex)
        }
    }
    
    func nextGuess(guess : Int) {
        if guess == sequence[nextGuessIndex] {  // correct
             nextGuessIndex += 1
            if nextGuessIndex == sequence.count {
                gameState = .won
            }
        } else {  // wrong
            gameState = .lost
            
        }
    }
    
    func advanceGameState() {
        switch gameState {
        case .notPlaying, .lost, .won:
            gameState = .memorizing
            resetGame()
        case .memorizing:
            gameState = .guessing
        default:
            assert(false, "Button should be disabled while guessing")
        }
    }
}
