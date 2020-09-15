//
//  USStatesListView.swift
//  US States
//
//  Created by jjh9 on 9/15/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct USStatesListView: View {
    @ObservedObject var usstates = USStates()
    
    var body: some View {
        //let _ = UserDefaults.standard.set(JSONDecoder(), forKey: "Decoder")
        
        return Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct USStatesListView_Previews: PreviewProvider {
    static var previews: some View {
        USStatesListView()
    }
}
