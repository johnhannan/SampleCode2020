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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
            
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
