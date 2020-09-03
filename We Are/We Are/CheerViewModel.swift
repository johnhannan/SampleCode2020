//
//  CheerViewModel.swift
//  We Are
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation

class CheerViewModel : ObservableObject{
    @Published var cheerModel = CheerModel()
    

    // Intents from View
    
    var firstCheer : String {cheerModel.weAreText}
    var secondCheer : String {cheerModel.pennStateText}
    
    var shouldShowFirstCheer : Bool {cheerModel.gameState == .weare}
    var shouldShowSecondCheer : Bool {cheerModel.gameState == .pennstate}
    
    var mascotImageName : String {cheerModel.mascotImage}
    
    func doACheer() {
        cheerModel.incrementCheerCount()
    }
}
