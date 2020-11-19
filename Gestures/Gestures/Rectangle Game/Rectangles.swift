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
            VStack {
                Color.gray
                    .gesture(dragGesture)
                
                HStack {
                    
                    Picker(selection: $rectangleModel.gameShape, label: Text("Shape")) {
                        ForEach(GameShapeNames.allCases) {
                            Text($0.rawValue.capitalized).tag($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Spacer()
                    Button(action: {rectangleModel.removeAll()})
                        {Image(systemName:"trash.fill")}
                    
                }.padding([.leading,.trailing])
                
            }
            
            
            
            ForEach(rectangleModel.rectangles) {rectangle in
                RectangleView(piece: rectangle)
            }
            
            if let rectangle = rectangleModel.inProgressRect {
                OutlineRectangleView(piece: rectangle)
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
