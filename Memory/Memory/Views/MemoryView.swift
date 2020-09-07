//
//  MemoryView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct MemoryView: View {
    
    //TODO: Need a View Model
    
    static let colors : [Color]  = [Color.red, .blue, .green, .yellow]
    
  
        var body: some View {
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.gray)  //TODO: make background color depend on game state
                    .edgesIgnoringSafeArea(.all)
                
                //TODO: these buttons should be disabled depending on game state
                VStack {
                    HStack {
                        GuessButtonView(colors: Self.colors, index:0)
                        GuessButtonView(colors: Self.colors, index:1)
                        
                    }
                    HStack {
                        GuessButtonView(colors: Self.colors, index:2)
                        GuessButtonView(colors: Self.colors, index:3)
                        
                    }
                    Spacer(minLength: 50)
                    SequenceView()
                    
                    PlayButtonView()
                    
                }
                .padding()
                
            }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryView()
    }
}

//
//func backgroundColor(for state: GameState) -> Color   {
//    switch state {
//    case .notPlaying:
//        return ViewConstants.notPlayingBackgroundColor
//    case .memorizing:
//        return ViewConstants.memorizingBackgroundColor
//    case .guessing:
//        return ViewConstants.guessingBackgroundColor
//    case .lost:
//        return ViewConstants.lostBackgroundColor
//    case .won:
//        return ViewConstants.wonBackgroundColor
//    }
//}
