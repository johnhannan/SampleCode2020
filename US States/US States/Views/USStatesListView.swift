//
//  USStatesListView.swift
//  US States
//
//  Created by jjh9 on 9/15/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI


struct USStatesListView: View {
    @Binding  var usstates : USStates
    
    var body: some View {

            List {
                ForEach(usstates.allStates.indices, id:\.self) {index in
                    NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
                        StateRowView(state: self.usstates.allStates[index])
                    }
                }
            }
            .navigationBarTitle("US States", displayMode: .inline)
    }
}

struct USStatesListView_Previews: PreviewProvider {
    @State static var usstates = USStates()
    static var previews: some View {
        USStatesListView(usstates: $usstates)
    }
}
