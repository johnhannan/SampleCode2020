//
//  HitTest.swift
//  Gestures
//
//  Created by jjh9 on 11/9/20.
//

import SwiftUI

struct HitTest: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Hello,    World!")
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 175, height: 175)
                    .allowsHitTesting(false)
                    .onTapGesture {
                        print("Circle tapped!")
                    }
            }
            Spacer()
            Text("Hit Test Me")
                .onTapGesture {
                    print("Hit Me")
                }
                .allowsHitTesting(false)
            Spacer()
        }
        .font(.largeTitle)
        .contentShape(Rectangle())
        .onTapGesture {
            print("Tapped")
        }
    }
}

struct HitTest_Previews: PreviewProvider {
    static var previews: some View {
        HitTest()
    }
}
