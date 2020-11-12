//
//  HamiltonCard.swift
//  Gestures
//
//  Created by jjh9 on 11/11/20.
//

import SwiftUI

struct HamiltonCard: View {
    var body: some View {

            Flippable(frontContent: {FlipImage(name: "Hamilton Front")},
                      backContent: {FlipImage(name: "Hamilton Back")})
        
    }
}

struct FlipImage  : View {
    var name : String
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
    }
}

struct HamiltonCard_Previews: PreviewProvider {
    static var previews: some View {
        HamiltonCard()
    }
}
