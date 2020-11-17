//
//  RectangleView.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

struct RectangleView: View {
    @EnvironmentObject var rectangleModel : RectangleModel
    var rectangle : Rect 
    @State private var offset = CGSize.zero
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
            .foregroundColor(colorForRectangle(rectangle))  
            .frame(width: rectangle.width, height: rectangle.height)  // depends on model object
            .position(rectangle.center)   // depends on model object
            .offset(offset)  // result of dragging
            .gesture(tapDrag)
    }
}

func colorForRectangle(_ rectangle:Rect) -> Color {
    return Color(red: rectangle.colorRGB.0, green: rectangle.colorRGB.1, blue: rectangle.colorRGB.2, opacity: 1.0)
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView(rectangle: Rect.anyRect)
    }
}
