//
//  CheerModel.swift
//  We Are
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation

struct CheerModel {
    
    private let cheerRounds = 3
    private let thankYouRounds = 1
    var totalCheers : Int {(cheerRounds + thankYouRounds) * 2}
    var currentCheerCount = 0
    
    mutating func incrementCheerCount() {
        currentCheerCount = (currentCheerCount + 1) % (totalCheers)
    }
}
