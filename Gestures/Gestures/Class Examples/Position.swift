//
//  Position.swift
//  Gestures
//
//  Created by jjh9 on 11/10/20.
//

import SwiftUI

struct Position: View {
    var body: some View {
        VStack {
            
            Text("Hello, Mary Lou!")
                .offset(x:100, y:100)
                //.position(x: 100, y: 100)
                .background(Color.red)
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                     
                })
             
           
            Text("Goodbye Heart")
        }
    }
}

struct Position_Previews: PreviewProvider {
    static var previews: some View {
        Position()
    }
}
