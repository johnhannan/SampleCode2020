//
//  GuessButtonView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct GuessButtonView: View {
    @EnvironmentObject var gameModel : GameModel
    
     let labels : [ButtonLabelView]
     let index : Int
     
     var body: some View {
        Button(action: { self.gameModel.nextGuess(guess: self.index) }) {
                  labels[index].font(.system(size: labelFontSize))
                  .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: shadowRadius)
            
        }.disabled(shouldDisableGuessButton)
     }
    
    let labelFontSize : CGFloat = 100
    let shadowRadius : CGFloat = 10
    var shouldDisableGuessButton : Bool {gameModel.gameState != .guessing }
}

struct ColorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GuessButtonView(labels: [ButtonLabelView(color:Color.purple)], index: 0)
    }
}


