//
//  CategoryItem.swift
//  US States
//
//  Created by jjh9 on 9/23/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct CategoryItem: View {
    @Binding var theState: USState
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(theState.image)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: frameSize, height: frameSize)
                .cornerRadius(5)
            Text(theState.name)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
    
    let frameSize : CGFloat = 155
}

struct CategoryItem_Previews: PreviewProvider {
    @State static var state = USStates().allStates[0]
    static var previews: some View {
        CategoryItem(theState: $state)
    }
}
