//
//  CategoryRow.swift
//  US States
//
//  Created by jjh9 on 9/23/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    @Binding var usstates : USStates
    let categoryName: String
    let property : ((USState) -> Bool)
    
    var nonEmpty : Bool {usstates.stateIndices(for: property).count > 0 }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if nonEmpty {
                Text(categoryName)
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(usstates.stateIndices(for: property), id:\.self) {index in
                            NavigationLink(destination: DetailView(state:self.$usstates.allStates[index])) {
                                CategoryItem(theState: self.$usstates.allStates[index])
                            }
                        }
                    }
                }.frame(height: 185)
            } else {
                EmptyView()
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    @State static var usstates = USStates()
    static var name = "Visited"
    static var property = {(state:USState) in true }
    static var previews: some View {
        CategoryRow(usstates: $usstates, categoryName: name, property: property)
    }
}
