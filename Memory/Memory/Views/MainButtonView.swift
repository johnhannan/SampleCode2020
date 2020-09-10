//
//  MainButtonView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct MainButtonView: View {
    @EnvironmentObject var gameModel : GameModel
    
    let buttonTextSize :CGFloat = 40
    
    var body : some View {
        Button(action: { self.gameModel.advanceGameState() }) {
            ZStack {
             
                Circle().scale(0.54).fill(Color.black)
                Circle().scale(0.52).fill(Color.white)
                Circle().scale(0.5).fill(Color.black)
                Text(mainButtonTitle).font(.system(size: self.buttonTextSize))
                    .foregroundColor(.white)
            }
        }.disabled(shouldDisableMainButton)
    }

    
    let buttonTextSize :CGFloat = 40
    
    var shouldDisableMainButton : Bool { gameModel.gameState == .guessing }
    
    var mainButtonTitle : String {
        switch gameModel.gameState {
        case .notPlaying, .lost, .won:
            return "New"
        case .memorizing:
            return "Start"
        case .guessing:
            return "-"
        }
    }
    
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonView()
    }
}
