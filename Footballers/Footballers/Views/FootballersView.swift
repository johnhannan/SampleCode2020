//
//  FootballersView.swift
//  Footballers
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

struct FootballersView: View {
    @EnvironmentObject var playersModel : PlayersModel
    
    var body: some View {
        List {
            ForEach(playersModel.footballers.indices, id:\.self) {index in
                NavigationLink(destination: PlayerView(player: $playersModel.footballers[index])) {
                    PlayerRowView(player: playersModel.footballers[index])
                }
            }
        } .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) { Text("Footballers")}
            }
    }
}


struct PlayerRowView : View {
    let player : Player
    var body: some View {
        Text(player.fullname)
    }
}


struct FootballersView_Previews: PreviewProvider {
    static var previews: some View {
        FootballersView()
    }
}
