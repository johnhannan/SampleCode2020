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
                
            } else {
                
                
                ForEach( sectionTitles(for: sectionStyle), id: \.self) { sectionTitle in
                    Section(header: Text(sectionTitle)) {
                        //Text(sectionTitle)
                        SectionViews(usstates: self.$usstates, property: sectionFilter(for: sectionStyle, key: sectionTitle))
                    }
                }
            }
        }
        .navigationBarTitle("US States", displayMode: .inline)
    }
    
    func sectionFilter(for sectionStyle:SectionStyle, key:String) ->  ((USState) -> Bool) {
        switch sectionStyle {
        case .byName:
            return {$0.name.firstLetter! == key}
        case .byDecade:
            return {$0.name.firstLetter! == key}
        default:
            assert(false, "No section titles for .none option")
        }
        
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



