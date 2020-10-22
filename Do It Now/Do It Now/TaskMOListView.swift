//
//  TaskMOListView.swift
//  Do It Now
//
//  Created by jjh9 on 10/21/20.
//

import SwiftUI

struct TaskMOListView: View {
    //@EnvironmentObject var tasks : Tasks
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var addTextItem : String = ""
    @State private var isAdding = false
    
    @State private var selectedItems = IndexSet()
    @State private var isEditing = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.timestamp, ascending: true)],
                      animation: .default)
        private var todoItems: FetchedResults<ToDoItem>
    
    
    var body: some View {
        NavigationView {
            
            
            List {
                ForEach(todoItems.indices, id:\.self) {index in
                    RowItem(item: todoItems[index].title!, index: index, editing: isEditing, selectedItems: $selectedItems)                }
                
                if isAdding {
                    TextField("Add", text: $addTextItem, onEditingChanged: { _ in })
                    {
                        let newItem = ToDoItem(context: viewContext)
                        newItem.title = addTextItem
                        newItem.timestamp = Date()
                        try? viewContext.save()
                        
                        addTextItem = ""
                        isAdding = false
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle() )
                }
            }
            .navigationTitle(Text("Things To Do"))
            .navigationBarItems(leading: addButton.disabled(isEditing),
                                trailing: editButton.disabled(isAdding))
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        selectedItems.map {todoItems[$0]}.forEach(viewContext.delete)
                        isEditing = false
                        selectedItems.removeAll()

                    }) {Image(systemName: "trash")}
                    .disabled(selectedItems.isEmpty)
                }
            }
            // this environment view modifier must come after adding the EditButton to the view
            //.environment(\.editMode, $editMode)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var addButton : some View {
        Button(action: {withAnimation{isAdding.toggle()}})
            { Image(systemName: "plus") }
    }
    private var editButton : some View {
        Button(action: {withAnimation{isEditing.toggle()}
            selectedItems.removeAll()
        })
            { Text(isEditing ? "Done" : "Edit") }
    }
    
}

struct TaskMOListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskMOListView()
    }
}
