//
//  Flippable.swift
//  Gestures
//
//  Created by jjh9 on 11/11/20.
//


import SwiftUI

struct Flippable<Content>: View where Content: View {
    @State private var degrees  : Double = 0.0  // rotation angle
    @State private var flipping  = true //is gesture for flipping from front to back?
    var isShowingBack : Bool {degrees < -90}
    
    var frontContent : () -> Content
    var backContent : () -> Content

    
    var body: some View {
        
        
        let swipe = DragGesture()
            .onChanged { (value) in
            }
            .onEnded { (value) in
            }
        
        Group {
            if isShowingBack {
                backContent()
            } else {
                frontContent()
            }
        }
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



