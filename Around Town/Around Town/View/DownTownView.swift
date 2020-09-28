//
//  DownTownView.swift
//  Around Town
//
//  Created by jjh9 on 9/28/20.
//

import SwiftUI

struct DownTownView: View {
    var body: some View {
        NavigationView {
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle(Text("Around Town"))
                .toolbar {
                    //  Principal placement same as inline displaymode title
                    ToolbarItem(placement: .principal) {Text("Around Town")}
                    ToolbarItem(placement: .bottomBar) {BottomBar()}
                    ToolbarItem(placement: .navigationBarLeading) {
                        LeadingButtons()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        TrailingButtons()
                    }
                }
            
        }
    }
}

struct TrailingButtons: View {
    var body : some View {
        HStack{
            Button(action: {}) {
                Image(systemName: "tuningfork")
            }
            Button(action: {}) {
                Image(systemName: "magnifyingglass")
            }
        }
    }
}

struct LeadingButtons: View {
    var body : some View {
        HStack{
            Button(action: {}) {
                Image(systemName: "gear")
            }
            Button(action: {}) {
                Image(systemName: "xmark.circle")
            }
        }
    }
}

struct BottomBar: View {
    var body : some View {
        
        HStack {
            Spacer()
            Text("Bottom")
            Spacer()
        }
    }
}

struct DownTownView_Previews: PreviewProvider {
    static var previews: some View {
        DownTownView()
    }
}
