//
//  ColorButtonView.swift
//  Memory
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct ColorButtonView: View {

     let colors : [Color]
     let index : Int
     
     var body: some View {
         Button(action: { /* add action */ }) {  //TODO: add action to make guess
             RoundedRectangle(cornerRadius: 10)
                  .fill(colors[index])
                 .aspectRatio(1.0, contentMode: .fit)
                 .shadow(radius: 20)
         }
     }
}

struct ColorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonView(colors: [.purple], index: 0)
    }
}
