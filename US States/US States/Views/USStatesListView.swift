//
//  USStatesListView.swift
//  US States
//
//  Created by jjh9 on 9/15/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI


struct USStatesListView: View {
    @State var usstates = USStates()
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(usstates.allStates.indices, id:\.self) {index in
                    
                    NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
                        StateRowView(state: self.usstates.allStates[index])
                    }
                    
                }
            }.navigationBarTitle("US States")
        }
    }
}

struct USStatesListView_Previews: PreviewProvider {
    static var previews: some View {
        USStatesListView()
    }
}
