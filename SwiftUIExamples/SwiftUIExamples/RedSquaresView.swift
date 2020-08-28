//
//  RedSquaresView.swift
//  Background
//
//  Created by jjh9 on 8/28/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct RedSquaresView: View {
    var body: some View {
        VStack {
            RedSquareRow()
            Spacer()
            RedSquareRow()
        }
    }
}



struct RedSquareRow : View {
    var body : some View {
        HStack {
            RedSquareView()
            Spacer()
            RedSquareView()
        }
    }
}

struct RedSquareView : View {
    var body : some View {
    Rectangle()
    .foregroundColor(.red)
    .frame(width: 50, height: 50, alignment: .center)
    }
}


//MARK: - Previews

struct RedSquaresView_Previews: PreviewProvider {
    static var previews: some View {
        RedSquaresView()
    }
}

struct RedSquareRowView_Previews: PreviewProvider {
    static var previews: some View {
        RedSquareRow()
    }
}

struct RedSquareView_Previews: PreviewProvider {
    static var previews: some View {
        RedSquareView()
    }
}
