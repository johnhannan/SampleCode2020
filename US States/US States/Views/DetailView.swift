//
//  DetailView.swift
//  US States
//
//  Created by jjh9 on 9/17/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Binding var state : USState
    var body: some View {
        List {
            HStack {
                Text("Founded in \(state.year)")
                Spacer()
                FavoriteButton(isFavorite: $state.favorite)
            }
            Text(state.info).padding()
            
            ForEach(state.images, id:\.self) {image in
                Image(image)
                .resizable()
                .padding()
                    .scaledToFill()
                    .frame(height: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
            }.padding()
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
