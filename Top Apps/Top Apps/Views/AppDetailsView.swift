//
//  AppDetailsView.swift
//  Top Apps
//
//  Created by jjh9 on 10/14/20.
//

import SwiftUI

struct AppDetailsView: View {
    var appInfo : AppInfo
    var body: some View {
        ScrollView {
        Text(appInfo.summary)
        }
            .padding()
            .navigationTitle(appInfo.title)
    }
}

//struct AppDetailsView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        AppDetailsView()
//    }
//}
