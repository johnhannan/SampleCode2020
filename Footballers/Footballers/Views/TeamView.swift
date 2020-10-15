//
//  TeamView.swift
//  Footballers
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

struct TeamView: View {
    @EnvironmentObject var playerModel : PlayersModel
    var body: some View {
        List{
            ForEach(playerModel.teams) {team in
                Section(header: TeamHeaderView(title: team.name)) {
                    ForEach(playerModel.playerIndicesFor(players: team.roster), id:\.self ) {index in
                        NavigationLink(destination: PlayerView(player: $playerModel.footballers[index])) {
                            PlayerRowView(player: playerModel.footballers[index])
                        }
                        
                    }
                }
            }
            
        }
    }
}

struct TeamHeaderView :View {
    var title: String
    var body: some View {
        Text(title).font(Font.largeTitle)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
    }
}
