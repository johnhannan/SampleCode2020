//
//  LikeButton.swift
//  Stories
//
//  Created by Goki on 12/2/20.
//

import SwiftUI

struct LikeButton: View {
    @State var liked: Bool = false
    
    @State var scale: CGFloat = 0.0
    @State var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            
            Image(systemName: "heart")
                .resizable()
                .scaledToFit()
                .foregroundColor(liked ? .pink : .black)
            
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.pink)
                .opacity(opacity)
                .scaleEffect(scale)
        }
        .frame(maxHeight: 25)
        .onTapGesture {
            liked.toggle()
        }
        .onChange(of: liked) { _ in
            if liked {
                scale = 0
                opacity = 0
                withAnimation(.easeOut(duration: 0.1)) {
                    scale = 1.25
                    opacity = 1
                }
                
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                    withAnimation(.easeOut(duration: 0.1)) {
                        scale = 1
                    }
                }
                
            } else {
                withAnimation(.easeOut(duration: 0.25)) {
                    scale = 5
                    opacity = 0
                }
            }
        }
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton()
    }
}
