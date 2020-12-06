//
//  StoryView.swift
//  Stories
//
//  Created by Goki on 11/29/20.
//

import SwiftUI

struct StoryView: View {
    let namespace: Namespace.ID
    
    let currentStory: Story?
    let story: Story
    
    let dismiss: () -> Void
    
    var isViewingStory: Bool {
        currentStory?.username == story.username
    }
    
//    @State private var verticalDragOffset: CGFloat = .zero
    
    var content: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                        
                Image(story.contentImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .frame(width: geometry.size.width)
                
                Spacer()
            }
        }
    }
    
    var header: some View {
        VStack {
            HStack {
                Image(story.profileImage)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 35, height: 35)
                    .matchedGeometryEffect(id: "\(story.id)-profile-photo", in: namespace)
                
                Text(story.username)
                    .bold()
                    .fixedSize()
                    .foregroundColor(.white)
                    .matchedGeometryEffect(id: "\(story.id)-username", in: namespace)
                
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
            .frame(height: 80)
            .padding(.horizontal)
            
            Spacer()
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
                .animation(.easeOut(duration: 0.1))
//                .opacity(Double(pow(2, -abs(verticalDragOffset)/500)))
            
            ZStack {
                content
                
                header
            }
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        verticalDragOffset = max(gesture.translation.height, 0)
//                    }
//                    .onEnded { gesture in
//                        if verticalDragOffset > 150 {
//                            withAnimation(.easeInOut) {
//                                dismiss()
//                            }
//                        } else {
//                            withAnimation(.easeOut) {
//                                verticalDragOffset = .zero
//                            }
//                        }
//                    }
//            )
//            .offset(x: 0, y: verticalDragOffset/pow(2, abs(verticalDragOffset)/500+1))
//            .scaleEffect(pow(2, -abs(verticalDragOffset)/2500))
        }
        
        
    }
}
