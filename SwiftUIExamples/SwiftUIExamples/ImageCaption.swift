//
//  ImageCaption.swift
//  Background
//
//  Created by jjh9 on 8/28/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct ImageCaption: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
        Image("Mascot0")
            Text("Nittany Lion")
        }
    }
}

struct ImageCaption_Previews: PreviewProvider {
    static var previews: some View {
        ImageCaption()
    }
}
