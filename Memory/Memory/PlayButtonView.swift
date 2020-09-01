//
//  PlayButtonView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct PlayButtonView: View {
    @EnvironmentObject var memoryViewModel : MemoryViewModel<Color>
    let buttonTextSize :CGFloat = 40
    
    var body : some View {
        Button(action: {self.memoryViewModel.playRound()}) {
            ZStack {
                Circle().scale(0.53).fill(backgroundColor(for: memoryViewModel.gameState))
                Circle().scale(0.5).fill(Color.black)
                Text(memoryViewModel.playButtonTitle).font(.system(size: self.buttonTextSize))
                    .foregroundColor(.white)
            }
        }.disabled(memoryViewModel.shouldDisablePlayButton)
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
    }
}
