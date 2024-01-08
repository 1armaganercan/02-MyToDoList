//
//  MyToDoListApp.swift
//  MyToDoList
//
//  Created by Armagan Ercan on 2023-09-05.
//

import SwiftUI


@main
struct MyToDoListApp: App {
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(todoList:TodoList())
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
