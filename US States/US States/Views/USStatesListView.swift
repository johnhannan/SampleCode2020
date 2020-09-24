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
    @Binding var usstates : USStates
    var sectionStyle : SectionStyle
    
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
                        SectionViews(usstates: self.$usstates,
                                     filter: sectionFilter(for: sectionStyle, sectionTitle: sectionTitle))
                        
                    }
                }
            }
        }
        .navigationBarTitle("US States", displayMode: .inline)
    }
    

    
    // generate array of section titles based on section style
    func sectionTitles(for sectionStyle:SectionStyle) -> [String] {
        switch sectionStyle {
        case .byName:
            return self.usstates.stateTitles(using: {$0.name.firstLetter!})
        case .byDecade:
            return self.usstates.stateTitles(using: {String($0.decadeAdmitted)})
        default:
            assert(false, "No section titles for .non option")
        }
    }
    
    // generate a filter (predicate function) that tests whether a state belongs in the section with title sectionTitle using sectionStyle (by Name or by Decade)
    func sectionFilter(for sectionStyle:SectionStyle, sectionTitle:String) ->  ((USState) -> Bool) {
        switch sectionStyle {
        case .byName:
            return {$0.name.firstLetter! == sectionTitle}
        case .byDecade:
            return {String($0.decadeAdmitted) == sectionTitle}
        default:
            assert(false, "No section filtering for .none option")
        }
    }
}



struct USStatesListView_Previews: PreviewProvider {
    @State static var usstates = USStates()
    static var sectionStyle : SectionStyle = .none
    static var previews: some View {
        USStatesListView(usstates: $usstates, sectionStyle: sectionStyle)
    }
}



