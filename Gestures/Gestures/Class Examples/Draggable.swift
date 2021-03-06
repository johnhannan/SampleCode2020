//
//  Draggable.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

//struct Draggable<Content>: View  where Content : View {
//    //  { Text("hi")} :  () -> Text
//    var content : () -> Content
//    @State private var offset : CGSize = CGSize.zero
//
//    var body: some View {
//        let pressAndDragGesture = LongPressGesture().sequenced(before:DragGesture())
//            .onChanged { (value) in
//                switch value {
//                case .first(true):
//                    print("Pressed")
//                case .second(true, let drag):
//                    self.offset = drag?.translation ?? .zero
//                default:
//                    break
//                }
//            }
//            .onEnded { (value) in
//                switch value {
//                case .first(true):
//                    print("Ended")
//                case .second(true, let drag):
//                    withAnimation {self.offset =  .zero}
//                default:
//                    break
//                }
//            }
//        content()
//            .offset(offset)
//            .gesture(pressAndDragGesture)
//    }
//}

struct Draggable: ViewModifier {
    //  { Text("hi")} :  () -> Text
    @State private var offset : CGSize = CGSize.zero
    
    func body(content: Content) -> some View {
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
                case .second(true, let _drag):
                    withAnimation {self.offset =  .zero}
                default:
                    break
                }
            }
        
        return content
            .offset(offset)
            .gesture(pressAndDragGesture)
    }
}

extension View {
    func draggable() -> some View {
        return self.modifier(Draggable())
    }
}
