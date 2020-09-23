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
        Text("Categories")
    }
}

struct Categories_Previews: PreviewProvider {
    @State static var states = USStates()
    
    static var previews: some View {
        Categories(usstates: $states)
    }
}
