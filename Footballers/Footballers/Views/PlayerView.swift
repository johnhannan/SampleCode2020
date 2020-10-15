//
//  PlayerView.swift
//  Footballers
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

struct PlayerView: View {
    @Binding var player : Player
    @Environment(\.editMode) var editMode
    
    var body: some View {
        ScrollView {
            //Text(player.info)
            TextEditor(text: $player.info)
            .padding()
                .disabled(self.editMode?.wrappedValue == .inactive)
        }
        .navigationTitle(Text(player.fullname))
        .navigationBarBackButtonHidden(editMode?.wrappedValue.isEditing ?? false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    @State static var player = Player(firstname: "Alexi", lastname: "Lalas", team: "USA", country:  "USA")
    static var previews: some View {
        PlayerView(player:$player)
    }
}
