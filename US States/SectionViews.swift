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
    var sectionStyle : SectionStyle
    var sectionTitle : String
    
    //var property : ((USState) -> Bool) { sectionFilter(for: sectionStyle, sectionTitle: sectionTitle)}
    
    var body : some View {
        let property : ((USState) -> Bool) = sectionFilter(for: sectionStyle, sectionTitle: sectionTitle)
        return
        ForEach(usstates.indices(for: property), id:\.self) { index in
            NavigationLink(destination: DetailView(state: self.$usstates.allStates[index])) {
                StateRowView(state: self.usstates.allStates[index])
            }
            
        }
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
}

struct SectionViews_Previews: PreviewProvider {
    @State static var usstates = USStates()
    static var sectionStyle : SectionStyle = .none
    static var title = "Title"
    static var previews: some View {
        SectionViews(usstates: $usstates, sectionStyle: sectionStyle, sectionTitle: title)
    }
}
