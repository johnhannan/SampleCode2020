//
//  StateRowView.swift
//  US States
//
//  Created by jjh9 on 9/17/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct StateRowView: View {
    var state : USState
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(state.name).font(Font.largeTitle)
                Text(state.capital)
                Text(String(format: "%04d", state.year))
            }
            Spacer()
            Image(state.name)
            .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: nil, height: 60, alignment: .center)
            Image(systemName: state.favorite ? "star.fill" : "star")
        }.padding()
    }
}

struct StateRowView_Previews: PreviewProvider {
    static let usstates = USStates()
    static var previews: some View {
        StateRowView(state: usstates.allStates[0])
    }
}
