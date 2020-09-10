//
//  MemoryView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct MemoryView: View {
    
    //TODO: generalize choices to more than colors
    let colors : [Color]  = [Color.red, .blue, .green, .yellow]
    
    @ObservedObject var gameModel = GameModel(with: 4)
    
    
    var colorSequence : [Color]  {gameModel.sequence.map{self.colors[$0]}}
    
        var body: some View {
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.background(for: gameModel.gameState)) 
                    .edgesIgnoringSafeArea(.all)
                
              
                VStack {

                    
                    HStack {
                        GuessButtonView(colors: self.colors, index:0)
                        GuessButtonView(colors: self.colors, index:1)
                        
                    }
                    HStack {
                        GuessButtonView(colors: self.colors, index:2)
                        GuessButtonView(colors: self.colors, index:3)
                        
                    }
                    Spacer(minLength: 50)
                    SequenceView(colorSequence: colorSequence)
                    
                    MainButtonView()
                    
                    HStack {
                        Spacer()
                        PreferenceButtonView()
                    }
                    
                    }.environmentObject(gameModel)
                .padding()
                
            }
        }
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryView()
    }
}

