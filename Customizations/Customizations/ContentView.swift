//
//  ContentView.swift
//  Customizations
//
//  Created by Goki on 12/1/20.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        Text("Avocado Toast")
            .padding()
            .background(Color.green)
            .mirror()
    }
}

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct Draggable: ViewModifier {
    @State var offset: CGSize = .zero
    @State var isBeingDragged = false
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        isBeingDragged = true
                    }.onEnded { gesture in
                        offset = .zero
                        isBeingDragged = false
                    }
            )
            .opacity(isBeingDragged ? 0.8 : 1)
            .scaleEffect(isBeingDragged ? 1.2 : 1)
    }
}

struct CardStyling: ViewModifier {
    
    var fontSize: CGFloat
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

extension View {
    func draggable() -> some View {
        self.modifier(Draggable())
    }
    
    func cardStyling(fontSize: CGFloat) -> some View {
        self.modifier(CardStyling(fontSize: fontSize))
    }
}

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
