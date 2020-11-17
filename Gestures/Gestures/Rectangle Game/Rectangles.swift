//
//  Rectangles.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

enum DragState : Equatable {
    case inactive
    case dragging
}

struct Rectangles: View {
    @StateObject var rectangleModel = RectangleModel()
    @GestureState private var dragState = DragState.inactive
    
    var body: some View {
        
        let dragGesture = DragGesture()
            .updating($dragState) { (value, state, transaction) in
                switch state {
                case .inactive:
                    rectangleModel.newRect(at: value.location)
                    state = .dragging
                case .dragging:
                    rectangleModel.updateRect(to: value.location)
                }
            }
            .onEnded { _ in
                rectangleModel.addRect()
            }

        ZStack {
            Color.gray
                .gesture(dragGesture)
            
            ForEach(rectangleModel.rectangles) {rectangle in
                RectangleView(rectangle: rectangle)
            }
            
            if let rectangle = rectangleModel.inProgressRect {
                OutlineRectangleView(rectangle: rectangle)
            }
            
        }
        .environmentObject(rectangleModel)
    }
}

struct Rectangles_Previews: PreviewProvider {
    static var previews: some View {
        Rectangles()
    }
}
