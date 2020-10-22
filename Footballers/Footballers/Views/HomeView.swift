//
//  HomeView.swift
//  Footballers
//
//  Created by jjh9 on 10/5/20.
//

import SwiftUI

struct HomeView: View {
 
    @EnvironmentObject var playersModel : PlayersModel
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \PlayerMO.lastname, ascending: true)],
                      animation: .default)
        private var players: FetchedResults<PlayerMO>

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TeamMO.name, ascending: true)],
                      animation: .default)
        private var teams: FetchedResults<TeamMO>
    

    
    
    var body: some View {
        NavigationView {
            VStack(spacing:60) {
                NavigationLink(destination: FootballersMOView(players: players)) {
                    HomeButton(title: "Players")
                }
                NavigationLink(destination: TeamMOView(teams: teams)) {
                    HomeButton(title: "Teams")
                }
            }.accentColor(Color.black)
        }
        .onAppear() {
            addPlayers()
        }
    }
    
    //MARK: - Core Data
    
    let alreadyLoadedKey = "AlreadyLoaded"
    func addPlayers() {
        let userDefaults = UserDefaults.standard
        let alreadyLoaded = userDefaults.bool(forKey: alreadyLoadedKey)
        if !alreadyLoaded {
            //TODO: Create Player managed objects
            playersModel.footballers.forEach {(player) in
                addPlayer(player: player)
                save()  // need this here so fetch results get updated!
            }
            
            userDefaults.set(true, forKey: alreadyLoadedKey)
            userDefaults.synchronize()
        }
    }
    
    func addPlayer(player:Player) {
        let newPlayer = PlayerMO(context: viewContext)
        newPlayer.firstname = player.firstname
        newPlayer.lastname = player.lastname
        newPlayer.country = player.country
        newPlayer.info = player.info
        if let team = teams.first(where: { (teamMO) -> Bool  in
                                    teamMO.name == player.teamname}) {
            newPlayer.team = team
        } else {  // new team
            let newTeam = TeamMO(context: viewContext)
            newTeam.name = player.teamname
            newTeam.addToRoster(newPlayer)
        }
    }
    
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct HomeButton : View {
    var title : String
    var body : some View {
        ZStack {
            Image("football").resizable()
                .frame(width: dim, height: dim, alignment: .center)
                .opacity(0.75)
            Text(title).font(Font.largeTitle)
        }
    }
    var dim : CGFloat = 200
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
