//
//  TaskListView.swift
//  Do It Now
//
//  Created by jjh9 on 10/11/20.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var tasks : Tasks
    
    //@Environment(\.editMode) var mode
    //@State var editMode = EditMode.inactive
    
    @State private var addTextItem : String = ""
    @State private var isAdding = false
    
    @State private var selectedItems = IndexSet()
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            
            
            List {
                ForEach(tasks.items.indices, id:\.self) {index in
                    RowItem(item: tasks.items[index], index: index, editing: isEditing, selectedItems: $selectedItems)                }
                    //                .onDelete { indexSet in
                    //                    tasks.deleteItems(indexSet: indexSet)
                    //                }
                    //.onMove { (indexSet, index) in
                    //    tasks.moveItems(offsets: indexSet, to: index)
                    //}
                
                if isAdding {
                    TextField("Add", text: $addTextItem, onEditingChanged: { _ in })
                    {
                        tasks.addItem(item: addTextItem)
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
                    Button(action: {tasks.deleteItems(indexSet: selectedItems)
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
        
        //        .sheet(isPresented: $isAdding) {
        //            TextField("Add", text: $addTextItem, onEditingChanged: {_ in}) {
        //                tasks.addItem(item: addTextItem)
        //                addTextItem = ""
        //                isAdding = false
        //            }
        //        }
        
        
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

struct RowItem : View {
    var item : String
    var index : Int
    var editing : Bool
    @Binding var selectedItems : IndexSet
    
    var body : some View {
        HStack {
            if editing {
                SelectButton(index: index, selectedItems: $selectedItems)
            }
            Text(item)
        }
        .listRowBackground(selectedItems.contains(index) ? Color.lightergray : Color.clear)
    }
    
    
}

struct SelectButton : View {
    var index : Int
    @Binding var selectedItems : IndexSet
    var body : some View {
        Button(action: {toggle(index, in: $selectedItems)},
               label: {imageFor(index, in: selectedItems) })
    }
    
    func toggle(_ index: Int, in selectedItems : Binding<IndexSet>) {
        if selectedItems.wrappedValue.contains(index) {
            selectedItems.wrappedValue.remove(index)
        } else {
            selectedItems.wrappedValue.insert(index)
        }
    }
    
    func imageFor(_ index:Int, in selectedItems:IndexSet) -> some View {
        let isSelected = selectedItems.contains(index)
        return  Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
            .renderingMode(.template)
            .foregroundColor(isSelected ? .blue : .gray)
    }

}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
