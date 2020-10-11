//
//  HomeView.swift
//  Footballers
//
//  Created by jjh9 on 10/5/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var playerModel : PlayersModel
    var body: some View {
        NavigationView {
        VStack(spacing:60) {
            NavigationLink(destination: FootballersView()) {
                HomeButton(title: "Players")
            }
            NavigationLink(destination: TeamView()) {
                HomeButton(title: "Teams")
            }
        }.accentColor(Color.black)
        }.environmentObject(playerModel)
    }
    

}

struct HomeButton : View {
    var title : String
    var body : some View {
        ZStack {
            Image("football").resizable()
                .frame(width: dim, height: dim, alignment: .center)
                .opacity(0.75)
            Text(title).font(Font.largeTitle)
        }
    }
    var dim : CGFloat = 200
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
