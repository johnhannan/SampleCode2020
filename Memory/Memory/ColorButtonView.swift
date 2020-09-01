//
//  ColorButtonView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct ColorButtonView: View {
    @EnvironmentObject var memoryViewModel : MemoryViewModel<Color>
     let colors : [Color]
     let index : Int
     
     var body: some View {
         Button(action: {self.memoryViewModel.nextGuess(index:self.index)}) {
             RoundedRectangle(cornerRadius: 10)
                  .fill(colors[index])
                 .aspectRatio(1.0, contentMode: .fit)
                 .shadow(radius: 20)
         }.disabled(memoryViewModel.shouldDisableColorButton)
     }
}

struct ColorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonView(colors: [.purple], index: 0)
    }
}
