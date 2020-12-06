//
//  StoryBubble.swift
//  Stories
//
//  Created by Goki on 11/29/20.
//

import SwiftUI

struct StoryBubble: View {
    let namespace: Namespace.ID
    
    let story: Story
    let currentStory: Story?
    let onTap: () -> Void
    
    var isViewingStory: Bool {
        currentStory?.username == story.username
    }
    
    var body: some View {
        VStack {
            Button(
                action: onTap,
                label: {
                    ZStack {
                        Image(story.profileImage)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 65, height: 65)
                            .zIndex(10)
                            .matchedGeometryEffect(id: "\(story.id)-profile-photo", in: namespace)
                    }
                }
            )
            .buttonStyle(StoryBubbleStyle())
            
            Text(story.username)
                .font(.footnote)
                .fixedSize()
                .matchedGeometryEffect(id: "\(story.id)-username", in: namespace)
        }
        .transition(.opacity)
    }
}

struct StoryBubbleStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.725))
    }
}
