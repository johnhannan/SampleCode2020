//
//  TaskListView.swift
//  Do It Now
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var tasks : Tasks
    @Environment(\.editMode) var mode
    
    @State var editMode = EditMode.inactive
    @State private var addTextItem : String = ""
    @State private var isAdding = false
    
    @State private var selectedItems = IndexSet()
    @State private var editing = false
    
    var body: some View {
        NavigationView {
            let myEditButton: Button<Text> = Button(editing ? "Done" : "Edit", action: {editing.toggle()})
            
            List {
                ForEach(tasks.items.indices, id:\.self) {index in
                    RowItem(item: tasks.items[index], index: index, editing: editing, selectedItems: $selectedItems)                }
//                .onDelete { indexSet in
//                    tasks.deleteItems(indexSet: indexSet)
//                }
                .onMove { (indexSet, index) in
                    tasks.moveItems(offsets: indexSet, to: index)
                }
                
//                if editMode.isEditing {
//                    TextField("Add", text: $addTextItem, onEditingChanged: { _ in })
//                        {
//                        tasks.addItem(item: addTextItem)
//                        addTextItem = ""
//                        editMode = .inactive
//                    }.textFieldStyle(RoundedBorderTextFieldStyle()
//                    )
//
//                }

            }
           
            .navigationTitle(Text("Things To Do"))
            .navigationBarItems(leading: addButton,
                                trailing: myEditButton)
            
            .environment(\.editMode, $editMode)
            
        }.sheet(isPresented: $isAdding) {
            TextField("Add", text: $addTextItem, onEditingChanged: {_ in}) {
                tasks.addItem(item: addTextItem)
                addTextItem = ""
                isAdding = false
            }
        }
    }
    
    private var addButton : some View {
        Button(action: {isAdding = true})
            { Image(systemName: "plus") }}
    

}

struct RowItem : View {
    var item : String
    var index : Int
    var editing : Bool
    @Binding var selectedItems : IndexSet
    
    var body : some View {
        HStack {
            if editing {
                Button(action: {toggle(selectedItems: $selectedItems, for: index)}, label: {Image(systemName: imageNameFor(index: index))})
            }
        Text(item)
        }
    }
    
    func toggle(selectedItems : Binding<IndexSet>, for index: Int) {
        if selectedItems.wrappedValue.contains(index) {
            selectedItems.wrappedValue.remove(index)
        } else {
            selectedItems.wrappedValue.insert(index)
        }
    }
    
    func imageNameFor(index:Int) -> String {
        selectedItems.contains(index) ? "circle.fill" : "circle"
    }
}



struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
