//
//  RectangleView.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

struct RectangleView: View {
    @EnvironmentObject var rectangleModel : RectangleModel
    var piece : GameShape 
    @State private var offset = CGSize.zero
    var body: some View {
        
        let tapGesture = LongPressGesture(minimumDuration: 0.1)
            .onEnded{ (value) in
                rectangleModel.bringToFront(piece)
            }
        let dragGesture = DragGesture()
            .onChanged{ (value) in
                offset = value.translation
            }
            .onEnded { (value) in
                rectangleModel.move(piece, by: offset)
                offset = CGSize.zero

            }
        let tapDrag = SimultaneousGesture(tapGesture,dragGesture)
        
        
        Group {
            switch piece.gameShape {
            case .rectangle:
                Rectangle()
            case .circle:
                Circle()
            }
        }
        
            .foregroundColor(colorForRectangle(piece))  
            .frame(width: piece.width, height: piece.height)  // depends on model object
            .zIndex(piece.zIndex)
            .position(piece.center)   // depends on model object
            .offset(offset)  // result of dragging
            .gesture(tapDrag)
    }
}

func colorForRectangle(_ rectangle:GameShape) -> Color {
    return Color(red: rectangle.colorRGB.0, green: rectangle.colorRGB.1, blue: rectangle.colorRGB.2, opacity: 1.0)
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView(piece: GameShape.anyRect)
    }
}
