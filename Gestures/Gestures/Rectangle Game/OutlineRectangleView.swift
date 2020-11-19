//
//  OutlineRectangleView.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

struct OutlineRectangleView: View {
    @EnvironmentObject var rectangleModel : RectangleModel
    var rectangle : GameShape
    var body: some View {
        Rectangle()
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
            // TODO: border with a dashed line
            .frame(width: rectangle.width, height: rectangle.height)
            .position(rectangle.center)
            
    }
}

struct OutlineRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineRectangleView(rectangle: GameShape.anyRect)
    }
}
