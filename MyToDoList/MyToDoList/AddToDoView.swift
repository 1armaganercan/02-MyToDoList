//
//  AddToDoView.swift
//  MyToDoList
//
//  Created by Armagan Ercan on 2023-09-06.
//

import SwiftUI
import CoreData

struct AddToDoView: View {
    
    @State private var isTaskAdded = false
    @ObservedObject var todoList:TodoList
    @State private var task = ""
    @State private var selecteddate = Date()
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView{
            VStack{
                RoundedRectangle(cornerRadius: 15).frame(width: 300, height: 50).shadow(color:.gray, radius: 2, y: 2)
                    .foregroundColor(.white)
                    .overlay(TextField("What whould you like to add?",text: $task).multilineTextAlignment(.center)
                    )
                Button{
                    
                    let tasks  = Tasks(context: managedObjectContext)
                    
                    tasks.task = String(task)
                    tasks.date = selecteddate
                    
                    
                    do {
                        try managedObjectContext.save()
                        
                        print("Data Saved Successfully")
                        
                    }catch{
                        let nsError = error as NSError
                        fatalError("Unresolved Error \(nsError)")
                        
                    }
                    
                    todoList.showAddTodoView = false
                }label:{
                    RoundedRectangle(cornerRadius: 15).frame(width:300,height:50)
                        .foregroundColor(.blue)
                        .overlay(Text("Add To Do").foregroundColor(.white).bold()
                        )
                }.padding()
                
                Spacer()
                
                
            }.navigationTitle("Add a note")
                .alert("Expense Added!", isPresented: $isTaskAdded){
                    Button{
                        isTaskAdded = false
                        task = ""
                        
                    }label:{
                        Text("OK")
                        
                    }
                    
                }
            
        }
    }
}
    


/*struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(todoList:TodoList())
    }
}*/
