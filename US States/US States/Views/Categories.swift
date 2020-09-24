//
//  Categories.swift
//  US States
//
//  Created by jjh9 on 9/23/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct Categories: View {
    @Binding var usstates : USStates
    var body: some View {
        
        Group {
            CategoryRow(usstates: $usstates, categoryName: "Visited", property: {$0.visited})
            CategoryRow(usstates: $usstates, categoryName: "Favorites", property: {$0.favorite})
            ForEach(usstates.centuries, id:\.self) { century in
                CategoryRow(usstates: $usstates, categoryName: "Founded in \(century)00's", property: {$0.centuryAdmitted == century})
            }
        }
    }
}

struct Categories_Previews: PreviewProvider {
    @State static var states = USStates()
    
    static var previews: some View {
        Categories(usstates: $states)
    }
}
