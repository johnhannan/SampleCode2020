//
//  ContentView.swift
//  Stories
//
//  Created by Goki on 11/26/20.
//

import SwiftUI

struct Story: Identifiable {
    var id = UUID()
    
    var username: String
    var profileImage: String
    var contentImage: String
}

struct Post: Identifiable {
    var id = UUID()
    
    var username: String
    var profileImage: String
    var contentImage: String
}

let stories: [Story] = [
    Story(username: "goki", profileImage: "goki", contentImage: "cat_in_box"),
    Story(username: "tussey_mtn", profileImage: "ski", contentImage: "tussey"),
    Story(username: "dr_j", profileImage: "dr_hannan", contentImage: "deer")
]

let posts: [Post] = [
    Post(username: "goki", profileImage: "goki", contentImage: "cat"),
    Post(username: "dr_j", profileImage: "dr_hannan", contentImage: "camping"),
    Post(username: "goki", profileImage: "goki", contentImage: "leaves"),
    Post(username: "dr_j", profileImage: "dr_hannan", contentImage: "trees")
]

struct ContentView: View {
    
    @State var currentStory: Story? = nil
    @Namespace var namespace
    
    var logo: some View {
        HStack {
            Text("sorta instagram")
                .bold()
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    var body: some View {
        ZStack {
            VStack {
                logo
                
                ScrollView(showsIndicators: false) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(stories) { story in
                                if story.username != currentStory?.username {
                                    StoryBubble(
                                        namespace: namespace,
                                        story: story,
                                        currentStory: currentStory,
                                        onTap: {
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                currentStory = story
                                            }
                                        }
                                    )
                                }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.leading, 5)
                    }
                    .padding(.bottom, 10)
                    
                    VStack {
                        ForEach(posts) { post in
                            PostView(post: post)
                        }
                    }
                }
            }
            if let story = currentStory {
                StoryView(
                    namespace: namespace,
                    currentStory: currentStory,
                    story: story,
                    dismiss: {
                        currentStory = nil
                    }
                )
                .zIndex(10)
                // .transition(.opacity) // opacity is the default, so this isn't necessary
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
