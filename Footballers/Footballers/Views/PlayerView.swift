//
//  PlayerView.swift
//  Footballers
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

struct PlayerView: View {
    @Binding var player : Player
    
    var body: some View {
        ScrollView {
            Text(player.info)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    @State static var player = Player(firstname: "Alexi", lastname: "Lalas", team: "USA", country:  "USA")
    static var previews: some View {
        PlayerView(player:$player)
    }
}
