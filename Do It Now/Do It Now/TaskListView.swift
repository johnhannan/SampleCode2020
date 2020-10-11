//
//  TaskListView.swift
//  Do It Now
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var tasks : Tasks
    
    var body: some View {
        List {
            ForEach(tasks.items, id:\.self) {item in
                Text(item)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
