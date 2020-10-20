//
//  FootballersView.swift
//  Footballers
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

struct FootballersView: View {
    @EnvironmentObject var playersModel : PlayersModel
    @State var showingAddPlayer : Bool = false
    @State private var searchText = ""
    
    
    var body: some View {
        
        // use a reader so we can scroll to first player, hiding the search bar above it
        ScrollViewReader { proxy in
            
            List {
                SearchBar(searchText: $searchText)
                
                ForEach(playersModel.playerIndicesFilteredBy(searchText: searchText), id:\.self) {index in
                    NavigationLink(destination: PlayerView(player: $playersModel.footballers[index])) {
                        PlayerRowView(player: playersModel.footballers[index])
                    }.id(index)
                }
            } .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) { Text("Footballers")}
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showingAddPlayer.toggle()}) {Image(systemName: "plus")}}
            }
            .sheet(isPresented: $showingAddPlayer) {
                AddPlayersView(playersModel:playersModel, showingAddPlayer: $showingAddPlayer)
            }
            .onAppear() {
                proxy.scrollTo(0, anchor: .top)  // hides the search bar
            }
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
