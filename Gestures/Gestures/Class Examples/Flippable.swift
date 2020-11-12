//
//  Flippable.swift
//  Gestures
//
//  Created by jjh9 on 11/11/20.
//


import SwiftUI

struct Flippable<Content>: View where Content: View {
    
    enum DraggingState {
        case right, left
    }
    
    @State private var degrees  : Double = 0.0  // rotation angle
    @State private var swiping  = DraggingState.left //swipe direction
    var isShowingBack : Bool {degrees < -90}
    
    var frontContent : () -> Content
    var backContent : () -> Content

    
    var body: some View {
        
        
        let swipe = DragGesture()
            .onChanged { (value) in
                let translation = Double(value.translation.width)
                switch swiping {
                case .left:
                    degrees = rotationDegreesFor(translation)
                case .right:
                    degrees = rotationDegreesFor(-180 + translation)
                }
               
            }
            .onEnded { (value) in
                if isShowingBack {
                    withAnimation {degrees = -180.0}
                    swiping = .right
                }
                else {
                    withAnimation {degrees = 0.0}
                    swiping = .left
                }
            }
        
        Group {
            if isShowingBack {
                backContent()
                    .rotation3DEffect(Angle(degrees:180), axis: (0,1,0))
            } else {
                frontContent()
            }
            
        }
        .rotation3DEffect(Angle(degrees:degrees), axis: (0,1,0))
        .gesture(swipe)
    }
    


  // Rotation should be between 0 and -180
    func rotationDegreesFor(_ translation: Double) -> Double {
        if translation > 0.0 {
            return  0.0
        } else if translation < -180.0 {
            return  -180.0
        } else {
            return translation
        }
    }
    
    
}



