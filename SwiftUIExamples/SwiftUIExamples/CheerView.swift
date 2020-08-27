//
//  ContentView.swift
//  SwiftUIExamples
//
//  Created by jjh9 on 8/25/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct CheerView: View {
    let colors  = [Color.red, .green, .blue, .orange, .pink, .purple]
    
    var body: some View {
        

        
//        List {
//            ForEach(0..<100) {i in
//                Text("Number \(i)")
//            }
//        }
//        VStack {
//
//            HStack {
//                ForEach(0..<5) {i in
//                    Text("abc\(i)")
//                }
//            }
//            Button("Cheer") {
//            }
//
        
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 50).fill(Color.blue)
            ZStack(alignment: .bottomTrailing) {
                Image("Mascot0")
                    .padding(.leading)
                    .frame(width: 200.0, height: 400.0)
                Text("Mastcot").padding()
                    .background(Color.white)
            }
            Spacer()
                
                Button("Cheer") {
                    
                }
            HStack {
                VStack {
                    Text("We Are!")
                    Text("Penn State")
                }
                EndingCheer(name: "Pepper")
                }
            
        }
        
    }
}


struct CheerView_Previews: PreviewProvider {
    static var previews: some View {
        CheerView()
    }
}

struct EndingCheer: View {
    let name : String
    var body: some View {
        VStack(alignment: .trailing, spacing: 20)
        {
            Text(name)
            Text("Thank You")
                .fontWeight(.bold)
                .foregroundColor(Color.purple)
                .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/7.0/*@END_MENU_TOKEN@*/)
            Text("You're Welcome")
        }.font(.title)
    }
}
