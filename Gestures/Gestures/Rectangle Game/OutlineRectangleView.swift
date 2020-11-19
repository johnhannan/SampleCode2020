//
//  OutlineRectangleView.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

struct OutlineRectangleView: View {
    @EnvironmentObject var rectangleModel : RectangleModel
    var piece : GameShape
    var body: some View {
        
        Group {
            switch piece.gameShape {
            case .rectangle:
                Rectangle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 2,dash: [5]) )
            case .circle:
                Circle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 2,dash: [5]) )
            }
        }
        .frame(width: piece.width, height: piece.height)
        .position(piece.center)
    }
    
}


struct OutlineRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineRectangleView(piece: GameShape.anyRect)
    }
}
