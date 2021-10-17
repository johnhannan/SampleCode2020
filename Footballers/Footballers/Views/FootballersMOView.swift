//
//  FootballersMOView.swift
//  Footballers
//
//  Created by jjh9 on 10/22/20.
//

import SwiftUI

struct FootballersMOView: View {
    var players: FetchedResults<PlayerMO>
    @Environment(\.managedObjectContext) private var viewContext
    @State var showingAddPlayer : Bool = false
    @State private var searchText = ""
    
    
    var body: some View {
        
        // use a reader so we can scroll to first player, hiding the search bar above it
        ScrollViewReader { proxy in
            
            List {
                SearchBar(searchText: $searchText)
                
                ForEach(players.indices, id:\.self) {index in
                    NavigationLink(destination: PlayerMOView(player: players[index]))
                    {
                        PlayerMORowView(player:  players[index])
                    }.id(index)  // only row that needs this is row 0
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) { Text("Footballers")}
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showingAddPlayer.toggle()}) {Image(systemName: "plus")}}
            }
            .sheet(isPresented: $showingAddPlayer) {
                AddPlayerMOView(showingAddPlayer: $showingAddPlayer)
                    .environment(\.managedObjectContext, viewContext)
            }
            .onAppear() {
                proxy.scrollTo(0, anchor: .top)  // hides the search bar
            }
        }
    }
}

struct PlayerMORowView : View {
    let player : PlayerMO
    var body: some View {
        Text(player.fullname)
    }
}

struct FootballersMOView_Previews: PreviewProvider {
    static let viewContext = PersistenceController.shared.container.viewContext
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: nil) static var players : FetchedResults<PlayerMO>
    static var previews: some View {
        FootballersMOView(players: players)
            .environment(\.managedObjectContext, viewContext)

    }
}
