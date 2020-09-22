//
//  USStatesListView.swift
//  US States
//
//  Created by jjh9 on 9/15/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

enum SectionStyle: String, CaseIterable {
    case none, byName, byDecade
}

var sectionStyle = SectionStyle.byName

struct USStatesListView: View {
    @Binding  var usstates : USStates
    
    var body: some View {
        
        if sectionStyle == .none {
            List {
                ForEach(usstates.allStates.indices, id:\.self) {index in
                    NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
                        StateRowView(state: self.usstates.allStates[index])
                    }
                }
            }
        } else {
            
        List {
            ForEach( sectionTitles(for: sectionStyle), id: \.self) { sectionTitle in
                Section(header: Text(sectionTitle)) {
                    SectionViews(usstates: $usstates) { $0.name.firstLetter! == sectionTitle}
                    }
                }
        }
    }
   // .navigationBarTitle("US States", displayMode: .inline)
}

    func sectionTitles(for sectionStyle:SectionStyle) -> [String] {
        switch sectionStyle {
        case .byName:
            return self.usstates.sectionTitles(for: {$0.name.firstLetter!})
        case .byDecade:
            return self.usstates.sectionTitles(for: {$0.name.firstLetter!})
        default:
            assert(false, "Shouldn't get here")
        }

    }
}


struct SectionViews : View {
    @Binding var usstates : USStates
    let property : ((USState) -> Bool)
    
    var body : some View {
        ForEach(usstates.allStates.indices(for: property), id:\.self) { index in
            NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
                StateRowView(state: self.usstates.allStates[index])
            }
   
        }
    }
}

struct USStatesListView_Previews: PreviewProvider {
    @State static var usstates = USStates()
    static var previews: some View {
        USStatesListView(usstates: $usstates)
    }
}

/*
 List {
 ForEach(usstates.allStates.indices, id:\.self) {index in
 NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
 StateRowView(state: self.usstates.allStates[index])
 }
 }
 }
 */

