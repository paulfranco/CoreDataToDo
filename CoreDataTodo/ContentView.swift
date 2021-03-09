//
//  ContentView.swift
//  CoreDataTodo
//
//  Created by Paul Franco on 3/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedOjectContext
    @FetchRequest(fetchRequest: TodoItem.getAllToDoItems()) var toDoItems:FetchedResults<TodoItem>
    
    @State private var newTodoItem = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Whats Next")) {
                    HStack {
                        TextField("New Item", text: self.$newTodoItem)
                        Button(action: {
                            let toDoItem = TodoItem(context: self.managedOjectContext)
                            toDoItem.title = self.newTodoItem
                            toDoItem.createdAt = Date()
                            
                            do {
                                try self.managedOjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            self.newTodoItem = ""
                            
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }.font(.headline)
                Section(header: Text("To Do's")) {
                    ForEach(self.toDoItems) { todoItem in
                        // do not force unwrap in real app
                        ToDoItemView(title: todoItem.title!, createdAt: "\(todoItem.createdAt!)")
                    }.onDelete { indexSet in
                        let deleteItem = self.toDoItems[indexSet.first!]
                        self.managedOjectContext.delete(deleteItem)
                        
                        do {
                            try self.managedOjectContext.save()
                            } catch {
                                // do not just print in real app
                                print(error)
                            }
                        }
                    }
                }
            .navigationTitle(Text("My List"))
            .navigationBarItems(trailing: EditButton())
            
        }
            
            
        }
        
        
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
