//
//  MemoryView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct MemoryView: View {
    
    static let colors : [Color]  = [Color.red, .blue, .green, .yellow]
    
  
        var body: some View {
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.gray)
                    .edgesIgnoringSafeArea(.all)
                
                //TODO: these buttons should be disabled depending on game state
                VStack {
                    HStack {
                        ColorButtonView(colors: Self.colors, index:0)
                        ColorButtonView(colors: Self.colors, index:1)
                        
                    }
                    HStack {
                        ColorButtonView(colors: Self.colors, index:2)
                        ColorButtonView(colors: Self.colors, index:3)
                        
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
