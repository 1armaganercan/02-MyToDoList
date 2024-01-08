//
//  DataController.swift
//  MyToDoList
//
//  Created by Armagan Ercan on 2023-09-06.
//

import Foundation
import CoreData


class DataController:ObservableObject{
    
    let container = NSPersistentContainer(name: "Tasks")
    
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Failed to load data in data coontroller \(error.localizedDescription)")
                
                
            }
        }
        
        
        
        
    }
    
    
}
