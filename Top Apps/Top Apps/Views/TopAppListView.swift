//
//  TopAppListView.swift
//  Top Apps
//
//  Created by jjh9 on 10/14/20.
//

import SwiftUI

struct TopAppListView: View {
    @ObservedObject var appModel = AppModel()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(appModel.topApps.indices, id:\.self) {index in
                    NavigationLink(
                        destination: AppDetailsView(appInfo: appModel.topApps[index]),
                        label: {
                            AppRow(appInfo: appModel.topApps[index], index: index)
                        })

                }
            }
            .navigationTitle(Text("Top Apps"))
          
        }
        .environmentObject(appModel)
    }
    

}

struct AppRow : View {
    @EnvironmentObject var appModel : AppModel
    var appInfo : AppInfo
    var index: Int
    var body : some View {
        HStack {
            //TODO: Image goes here
            
            VStack {
                Text(appInfo.title)
                Text(appInfo.author)
            }
        }
    }
}


struct TopAppListView_Previews: PreviewProvider {
    static var previews: some View {
        TopAppListView()
    }
}
