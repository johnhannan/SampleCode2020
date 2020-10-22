//
//  PlayerMOVieiw.swift
//  Footballers
//
//  Created by jjh9 on 10/22/20.
//

import SwiftUI

struct PlayerMOView: View {
    @ObservedObject var player : PlayerMO
    @Environment(\.editMode) var editMode
    
    
    
    var body: some View {
        ScrollView {
           
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

//struct PlayerMOVieiw_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerMOVieiw()
//    }
//}
