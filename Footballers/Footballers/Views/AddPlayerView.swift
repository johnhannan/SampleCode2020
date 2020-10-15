//
//  AddPlayerView.swift
//  Footballers
//
//  Created by jjh9 on 10/6/20.
//

import SwiftUI

struct AddPlayersView: View {
    var playersModel : PlayersModel
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
                        ForEach(playersModel.teams.map{$0.name}, id:\.self) { name in
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
                        playersModel.addPlayer(player: player)
                        showingAddPlayer.toggle()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
    
    private var isValid : Bool {[firstname,lastname,teamname,country].allSatisfy{!$0.isEmpty}}
    
}

//struct AddPlayersView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPlayersView(showingAddPlayer: .constant(false))
//    }
//}
