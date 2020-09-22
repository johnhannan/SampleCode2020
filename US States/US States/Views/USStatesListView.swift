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



struct USStatesListView: View {
    @Binding  var usstates : USStates
    @Binding var sectionStyle : SectionStyle
    
    var body: some View {
        List {
            if sectionStyle == .none {
                
                ForEach(usstates.allStates.indices, id:\.self) {index in
                    NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
                        StateRowView(state: self.usstates.allStates[index])
                    }
                }
                
            } else {  // by Name or by Decade
                        // we use function sectionTitles(for:) and sectionFilter(for:) to customize based on the value of sectionStyle
                
                ForEach( sectionTitles(for: sectionStyle), id: \.self) { sectionTitle in
                    Section(header: Text(sectionTitle)) {
                        SectionViews(usstates: self.$usstates, property: sectionFilter(for: sectionStyle, sectionTitle: sectionTitle))
                    }
                }
            }
        }
        .navigationBarTitle("US States", displayMode: .inline)
    }
    
    // generate a filter (predicate function) that tests whether a state belongs in the section with title sectionTitle using sectionStyle (by Name or by Decade)
    func sectionFilter(for sectionStyle:SectionStyle, sectionTitle:String) ->  ((USState) -> Bool) {
        switch sectionStyle {
        case .byName:
            return {$0.name.firstLetter! == sectionTitle}
        case .byDecade:
            return {$0.name.firstLetter! == sectionTitle}
        default:
            assert(false, "No section filtering for .none option")
        }
        
    }
    
    // generate array of section titles based on section style
    func sectionTitles(for sectionStyle:SectionStyle) -> [String] {
        switch sectionStyle {
        case .byName:
            return self.usstates.stateTitles(for: {$0.name.firstLetter!})
        case .byDecade:
            return self.usstates.stateTitles(for: {$0.name.firstLetter!})
        default:
            assert(false, "No section titles for .non option")
        }
        
    }
}

// views for all the states satisfying the given property.  Obtains bindings for states by finnding the indices of the states satisfying the property.
struct SectionViews : View {
    @Binding var usstates : USStates
    let property : ((USState) -> Bool)
    
    var body : some View {
        ForEach(usstates.indices(for: property), id:\.self) { index in
            NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
                StateRowView(state: self.usstates.allStates[index])
            }
            
        }
    }
}

struct USStatesListView_Previews: PreviewProvider {
    @State static var usstates = USStates()
    @State static var sectionStyle : SectionStyle = .none
    static var previews: some View {
        USStatesListView(usstates: $usstates, sectionStyle: $sectionStyle)
    }
}



