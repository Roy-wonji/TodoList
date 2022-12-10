//
//  AddTask.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/10.
//

import SwiftUI

struct AddNewTask: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: Task Values
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: Date = Date()
    
    // MARK: Core Data Context
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var taskModel: TaskViewModel
    var body: some View {
        NavigationView{
            List{
                Section {
                    TextField("Go to work", text: $taskTitle)
                } header: {
                    Text(" Todo List 제목 🗓")
                }
                .onAppear(perform: UIApplication.shared.hideKeyboard)

                Section {
                    TextField("Nothing", text: $taskDescription)
                } header: {
                    Text("Todo List 해야 할일 📝")
                }
                .onAppear(perform: UIApplication.shared.hideKeyboard)
                // Disabling Date for Edit Mode
                if taskModel.editTask == nil{
                    Section {
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    } header: {
                        Text(" Todo List 날짜 추가")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("할일 추가 하기")
            .navigationBarTitleDisplayMode(.inline)
            // MARK: Disbaling Dismiss on Swipe
            .interactiveDismissDisabled()
            // MARK: Action Buttons
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("추가하기"){
                        
                        if let task = taskModel.editTask{
                            
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                        }
                        else{
                            let task = Task(context: context)
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                            task.taskDate = taskDate
                        }
                        
                        // Saving
                        try? context.save()
                        // Dismissing View
                        dismiss()
                    }
                    .disabled(taskTitle == "" || taskDescription == "")
                    .foregroundColor(ColorAsset.mainViewColor)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소하기"){
                        dismiss()
                    }
                    .foregroundColor(ColorAsset.mainViewColor)
                }
            }
            // Loading Task data if from Edit
            .onAppear {
                if let task = taskModel.editTask{
                    taskTitle = task.taskTitle ?? ""
                    taskDescription = task.taskDescription ?? ""
                }
            }
        }
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
    }
}
