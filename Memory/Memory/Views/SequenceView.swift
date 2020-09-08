//
//  SequenceView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

// The sequence of dots that the user is trying to guess[
struct SequenceView: View {
    //TODO: need to parameterize the colorSequence from current model state
    @EnvironmentObject var gameModel : GameModel
    
    var colorSequence : [Color]
    
    let circleWidth :CGFloat = 15.0

    var body: some View {
        HStack{
            ForEach(colorSequence.indices, id:\.self) { i in
                Circle()
                    .fill(self.colorSequence[i])
                    .frame(width: self.circleWidth, height: self.circleWidth, alignment: .center)
                //TODO:  Need to show the correct number of items
                    .opacity(i<self.visibilityCount ? 1.0 : 0.0)
                
            }
        }
    }
    
    var visibilityCount : Int {
        switch gameModel.gameState {
        case .memorizing, .won:
            return colorSequence.count
        case .guessing:
            return gameModel.nextGuessIndex
        default:
            return 0
        }
    }
}

//struct SequenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        SequenceView()
//    }
//}
