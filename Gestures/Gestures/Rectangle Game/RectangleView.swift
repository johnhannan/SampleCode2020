//
//  RectangleView.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

struct RectangleView: View {
    @EnvironmentObject var rectangleModel : RectangleModel
    
    var body: some View {
        
        let tapGesture = LongPressGesture(minimumDuration: 0.1)
            .onEnded{ (value) in
                
            }
        let dragGesture = DragGesture()
            .onChanged{ (value) in
                offset = value.translation
            }
            .onEnded { (value) in
                offset = CGSize.zero

            }
        let tapDrag = SimultaneousGesture(tapGesture,dragGesture)
        
        
        Rectangle()
            .foregroundColor(color.red)  // worry about individual colors later

            .gesture(tapDrag)
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView()
    }
}
