//
//  TeamMOView.swift
//  Footballers
//
//  Created by jjh9 on 10/22/20.
//

import SwiftUI

struct TeamMOView: View {
    var teams: FetchedResults<TeamMO>
    
    var body: some View {
        List{
            ForEach(teams) {team in
                Section(header: TeamHeaderView(title: team.name)) {
                    ForEach(Array(team.roster).sorted(by: {(player1:PlayerMO, player2:PlayerMO) -> Bool in player1.lastname < player2.lastname}), id:\.self ) {player in
                        NavigationLink(destination: PlayerMOView(player: player)) {
                            PlayerMORowView(player: player)
                        }
                        
                    }
                }
            }
            
        }
    }
}

//struct TeamHeaderView :View {
//    var title: String
//    var body: some View {
//        Text(title).font(Font.largeTitle)
//    }
//}

//struct TeamMOView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamMOView()
//    }
//}
