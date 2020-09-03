//
//  PlayButtonView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct PlayButtonView: View {
  
    let buttonTextSize :CGFloat = 40
    
    //TODO: button should be disabled based on game state
    var body : some View {
        Button(action: { /* add action */ }) {  //TODO: add action to change state of game
            ZStack {
             
                Circle().scale(0.54).fill(Color.black)
                Circle().scale(0.52).fill(Color.white)
                Circle().scale(0.5).fill(Color.black)
                Text("Play").font(.system(size: self.buttonTextSize))
                    .foregroundColor(.white)
            }
        }
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
    }
}
