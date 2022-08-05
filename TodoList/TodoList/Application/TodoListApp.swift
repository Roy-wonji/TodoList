//
//  TodoListApp.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/04.
//

import SwiftUI

@main
struct TodoListApp: App {
    
   @State var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
