//
//  ContentView.swift
//  MyToDoList
//
//  Created by Armagan Ercan on 2023-09-05.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    @ObservedObject var todoList: TodoList
    
    @FetchRequest(entity: Tasks.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.date, ascending: false)])

    private var items: FetchedResults<Tasks>
    
   //To Update Task
    //var taskToUpdate :  FetchedResults<Tasks>.Element
    
    let date = Date()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd.MM.yyyy"
           return formatter
       }()
    

    
    var body: some View {

        NavigationView{
            
            VStack{
                List{
                    ForEach(items) { todo in
                        HStack{
                            
                            Text("\(todo.task ?? "Unknown Item")")
                            Spacer()
                            
                            if let date = todo.date {
                                Text(dateFormatter.string(from: date))
                                } else {
                                    Text("No Date")
                                }
     
                            //Text("\(todo.date ?? formattedDate)")
                            
                            
                                Button(action:{
                                    deleteItems(duty: todo)
                                })  {
                                    Image(systemName: "trash")
                                }
                                .padding()
                                Button("Update",action:{
                                    
                                    updateTask(task: todo , newTitle: "")
                                    todoList.showAddTodoView.toggle()
                                }).sheet(isPresented: $todoList.showAddTodoView){
                                   
                                    AddToDoView(todoList: todoList)
                                    
                                }
                                
                            
                        }
                    }
                }
            }.navigationTitle("To Do List")
                .toolbar{
                    ToolbarItem (placement: .navigationBarTrailing) {
                        Button(action:{
                            todoList.showAddTodoView.toggle()
                            
                        }) {
                            Text("Add ToDo")
                            
                        }
                    }
                    
                }.sheet(isPresented: $todoList.showAddTodoView) {
                    AddToDoView(todoList: todoList)
                    
                }
        }
    }
    
    func deleteItems(duty:Tasks){
        withAnimation{
            
            managedObjectContext.delete(duty)

        }

    }
    // Function for taskupdate
    func updateTask(task: Tasks, newTitle: String) {
        // Update the properties
        task.task = newTitle
        

        // Save the managed object context
        do {
            try managedObjectContext.save()
        } catch {
            print("Error updating task: \(error)")
        }
    }
}

class TodoList:ObservableObject{
    
   @Published var showAddTodoView = false
   @Published var showUpdateTodoView = false

}


/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(todoList: TodoList, taskToUpdate: FetchedResults<Tasks>.Element)
    }
}*/
