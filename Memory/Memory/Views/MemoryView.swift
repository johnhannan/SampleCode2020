//
//  MemoryView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct MemoryView: View {
    
    @ObservedObject var gameModel = GameModel(with: 4)  // 4 = colors.count
    
    let themes = Themes()
    @State var selectedThemeIndex = 0
    var currentTheme  : [ButtonLabelView] {themes[selectedThemeIndex] }
    var currentSequence: [ButtonLabelView] {
        gameModel.sequence.map { (i) -> ButtonLabelView in currentTheme[i]
        }
    }
    
    
    //let colors : [Color]  = [Color.red, .blue, .green, .yellow]
    //var colorSequence : [Color]  {gameModel.sequence.map{self.colors[$0]}}
    

        var body: some View {
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.background(for: gameModel.gameState)) 
                    .edgesIgnoringSafeArea(.all)
                
              
                VStack {

                    
                    HStack {
                        GuessButtonView(labels: currentTheme, index:0)
                        GuessButtonView(labels: currentTheme, index:1)
                        
                    }
                    HStack {
                        GuessButtonView(labels: currentTheme, index:2)
                        GuessButtonView(labels: currentTheme, index:3)
                        
                    }
                    Spacer(minLength: 50)
                    SequenceView(currentSequence: currentSequence)
                    
                    MainButtonView()
                    
                    HStack {
                        Spacer()
                        PreferenceButtonView(themes: themes, selectedThemeIndex: $selectedThemeIndex)
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

