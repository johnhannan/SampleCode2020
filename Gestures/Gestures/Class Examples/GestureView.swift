//
//  GestureView.swift
//  Gestures
//
//  Created by jjh9 on 11/9/20.
//

import SwiftUI

struct GestureView: View {
    @State private var tapCount = 0
    @State private var pressCount = 0
    @State private var doubleCount = 0
    @State private var rotationAngle : Angle = Angle.zero
    @State private var scaleFactor : CGFloat = 1.0
    @State private var offset : CGSize = CGSize.zero
    @GestureState private var rotation : Angle = Angle.zero
    
    var body: some View {
        let tapGesture = TapGesture()
            .onEnded { tapCount += 1}
        let doubleTapGesture = TapGesture(count: 2)
            .onEnded { doubleCount += 1}
        let longPressGesture = LongPressGesture(minimumDuration: 0.5, maximumDistance: 20)
            .onEnded {_ in pressCount += 1}
        let rotationGesture = RotationGesture()
            .updating($rotation, body: {(value, state, transaction) in
                state = value
            })
//            .onChanged { (value) in
//                self.rotationAngle = value
//            }
        let magnifyGesture = MagnificationGesture()
            .onChanged { (value) in
                scaleFactor = value
            }
        
        let magAndRotateGesture = magnifyGesture.simultaneously(with: rotationGesture)
            .onEnded { (_) in
                withAnimation {
                    rotationAngle = Angle.zero
                    scaleFactor = 1.0
                }
            }
        
        
        let pressAndDragGesture = LongPressGesture().sequenced(before:DragGesture())
            .onChanged { (value) in
                switch value {
                case .first(true):
                    print("Pressed")
                case .second(true, let drag):
                    self.offset = drag?.translation ?? .zero
                default:
                    break
                }
            }
            .onEnded { (value) in
                switch value {
                case .first(true):
                    print("Ended")
                case .second(true, let drag):
                    withAnimation {self.offset =  .zero}
                default:
                    break
                }
            }
        
        
        let dragGesture = DragGesture()
            .onChanged { (value) in
                self.offset = value.translation  // was value.location
            }
            .onEnded { (value) in
                withAnimation {self.offset = CGSize.zero}
            }
        
        return VStack(spacing:30) {
            Text("Double: \(doubleCount)")
                .gesture(doubleTapGesture)
                .gesture(tapGesture)
            
            Text("Taps: \(tapCount)")
                .gesture(doubleTapGesture)
                //.gesture(tapGesture)
                .onTapGesture {
                    tapCount += 1
                }
            
            Text("Presses: \(pressCount)")
                .gesture(longPressGesture)
            
            Image("Penn Seal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .position(CGPoint.zero)
                .scaleEffect(scaleFactor)
                .rotationEffect(rotation)
               
                .gesture(rotationGesture)
                //.gesture(magnifyGesture)
                //.gesture(magAndRotateGesture)
            
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.orange)
                .frame(width: 100, height: 100)
                .draggable()
            
                //.position(location)
                //.offset(offset)
                //.gesture(dragGesture)
                //.gesture(pressAndDragGesture)
            
            Text("Bottom Text")
        }
        .font(.largeTitle)
    }
}

struct GestureView_Previews: PreviewProvider {
    static var previews: some View {
        GestureView()
    }
}
