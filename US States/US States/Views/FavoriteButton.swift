//
//  FavoriteButton.swift
//  US States
//
//  Created by jjh9 on 9/17/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite : Bool
    var body: some View {
        Button(action: {self.isFavorite.toggle()}) { 
            Image(systemName: isFavorite ? "star.fill" : "star")
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    @State static var favorite = true
    static var previews: some View {
        FavoriteButton(isFavorite: $favorite)
    }
}
