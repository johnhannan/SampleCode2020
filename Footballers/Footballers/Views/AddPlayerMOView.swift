//
//  AddPlayerMOView.swift
//  Footballers
//
//  Created by jjh9 on 10/22/20.
//

import SwiftUI
import CoreData

struct AddPlayerMOView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TeamMO.name, ascending: true)],
                      animation: .default)
        private var teams: FetchedResults<TeamMO>
    
    
    @Binding var showingAddPlayer : Bool
    
    @State private var firstname : String = ""
    @State private var lastname : String = ""
    @State private var teamname : String = ""
    @State private var country : String = ""
  
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Enter Player Details")) {
                    TextField("First Name", text: $firstname)
                    TextField("Last Name", text: $lastname)
                    Picker("Team", selection:$teamname) {
                        ForEach(teams.map{$0.name}, id:\.self) { name in
                            Text(name)
                        }
                    }
                    TextField("Country", text: $country)
                }

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {showingAddPlayer = false}
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let player = Player(firstname: firstname, lastname: lastname, team: teamname, country: country)
                        addPlayer(player: player)
                        showingAddPlayer.toggle()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
    
    private var isValid : Bool {[firstname,lastname,teamname,country].allSatisfy{!$0.isEmpty}}
    
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
    
}

//struct AddPlayerMOView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPlayerMOView()
//    }
//}
