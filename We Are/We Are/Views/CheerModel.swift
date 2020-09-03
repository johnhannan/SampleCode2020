//
//  CheerModel.swift
//  We Are
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation

enum State {
    case ready, weare, pennstate
}

struct CheerModel {
    
    private let cheerRounds = 3
    private let thankYouRounds = 1
    
    var gameState : State {
        if currentCheerCount == 0 {
            return .ready
        } else if currentCheerCount % 2 == 1 {
                return .weare
            } else {
                return .pennstate
            }
        }
    
    
    
    // total Cheers includes the initial image (ready state)
    private var totalCheers : Int {1 + (cheerRounds + thankYouRounds) * 2}
    private var currentCheerRound : Int {(currentCheerCount+1)/2}

    private var isWeAreRound : Bool {currentCheerRound <= cheerRounds}
    
    var weAreText : String { isWeAreRound  ? "We Are" : "Thank You"}
    var pennStateText : String {  isWeAreRound ? "Penn State" : "You're Welcome" }
    
    var mascotImage : String {
        switch gameState {
        case .ready:
            return "Mascot0"
        case .weare:
              return "Mascot1"
        case .pennstate:
            return "Mascot1Reversed"
  
        }
    }
    
    
    private var currentCheerCount = 0
    mutating func incrementCheerCount() {
        currentCheerCount = (currentCheerCount + 1) % (totalCheers)
    }
}
