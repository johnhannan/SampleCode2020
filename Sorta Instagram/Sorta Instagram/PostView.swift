//
//  Post.swift
//  Stories
//
//  Created by Goki on 11/26/20.
//

import SwiftUI

struct PostView: View {

    let post: Post
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(post.profileImage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 25, height: 25)
                
                Text(post.username)
                    .offset(y: -1.5)
                
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.leading, 10)
            .padding(.trailing)
            .padding(.vertical)
            .background(Color(UIColor.systemBackground))
            
            Image(post.contentImage)
                .resizable()
                .scaledToFill()
                .zIndex(-1)
            
            HStack(spacing: 15) {
                LikeButton()
                
                Image(systemName: "bubble.right")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 25)
                Spacer()
                
                Image(systemName: "bookmark")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 25)
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color(UIColor.systemBackground))
        }
    }
}
