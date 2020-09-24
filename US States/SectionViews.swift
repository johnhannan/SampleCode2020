//
//  SectionViews.swift
//  US States
//
//  Created by jjh9 on 9/23/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

// views for all the states satisfying the filter based on section style and title.  Obtains bindings for states by finding the indices of the states satisfying the property.
struct SectionViews : View {
    @Binding var usstates : USStates
    var filter : ((USState) -> Bool)
    
    var body : some View {

        ForEach(usstates.stateIndices(for: filter), id:\.self) { index in
            NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
                StateRowView(state: self.usstates.allStates[index])
            }
        }
    }
}

struct SectionViews_Previews: PreviewProvider {
    @State static var usstates = USStates()
    static var sectionStyle : SectionStyle = .none
    static var title = "Title"
    static var previews: some View {
        SectionViews(usstates: $usstates, filter: {_ in true})
    }
}
