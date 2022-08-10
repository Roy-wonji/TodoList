//
//  TodoListApp.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/04.
//

import SwiftUI
import CoreData

@main
struct TodoListApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TodoLIstMainHomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
