//
//  ContentView.swift
//  Stories
//
//  Created by Goki on 11/26/20.
//

import SwiftUI

struct Task {
    var description: String
    var completed: Bool
    
    init(description: String) {
        self.description = description
        self.completed = false
    }
}

struct ContentView: View {
    
    @State var tasks = [
        Task(description: "Floss"),
        Task(description: "Make bed"),
        Task(description: "Walk dog"),
    ]
    
    @State var showCompletedNotice = false
    
    var dailyTasksCompleted: Bool {
        !tasks.map({ $0.completed }).contains(false)
    }
    
    var completedNotice: some View {
        VStack {
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(5)
            
            Text("Completed")
                .bold()
        }
        .foregroundColor(.white)
        .frame(width: 100, height: 100)
        .padding(15)
        .background(Color.gray.opacity(0.7))
        .cornerRadius(25)
    }
    
    var background: some View {
        dailyTasksCompleted
            ? Color.green
            : Color.yellow
    }
    
    var body: some View {
        ZStack {
            background
                .animation(.easeInOut(duration: 3))
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Daily Tasks")
                        .bold()
                    
                    Spacer()
                }
                
                ForEach(tasks.indices) { index in
                    TaskView(task: $tasks[index])
                }
            }
            .padding(25)
            .onChange(of: dailyTasksCompleted) { _ in
                if dailyTasksCompleted {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        showCompletedNotice = true
                    }
                    
                    // Can't use another withAnimation + .delay here to do this!
                    Timer.scheduledTimer(withTimeInterval: 1.0 + 0.5, repeats: false) { _ in
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            showCompletedNotice = false
                        }
                    }
                }
            }
            
            if showCompletedNotice {
                completedNotice
                    .transition(AnyTransition.scale)
            }
        }
    }
    
}

struct TaskView: View {
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Group {
                Circle()
                    .fill(task.completed ? Color.green : Color.gray)
                    .frame(width: 25, height: 25)
                
                Text(task.description)
                    .strikethrough(task.completed, color: .black)
            }
            .onTapGesture {
                task.completed.toggle()
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
