//
//  DynamicFilteredVIew.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/10.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject{
    //MARK: - Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (T) -> Content
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @State var animate: Bool = false
    
    //MARK: - Building Custom ForEach which will give CoreData object to build View
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T) -> Content) {
        //MARK: - Predicate to Filter current date Task
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: dateToFilter)
        let tommorow = calendar.date(byAdding: .day, value: 1, to: today)!
        // Filter Key
        let filterKey = "taskDate"
        // This will fetch task between today and tommorow which is 24 hours
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tommorow])
        
        // Intializing Request With NSPredicate
        // Adding Sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        Group {
            if request.isEmpty {
                GeometryReader { geometry in
                    VStack(spacing: 5) {
                        Text("리스트가 없어요 😰")
                            .fontWeight(.black)
                            .foregroundColor(ColorAsset.fontColor.opacity(1.0))
                            .font(.title)
                        Text("혹시 오늘 할일이 없어요 ☹️?")
                            .fontWeight(.semibold)
                            .font(.custom("나눔손글씨 둥근인연", size: 15))
                        Text("만약에 할일이  있으면  Todo 리스트에 추가 버튼을 눌러서")
                            .fontWeight(.semibold)
                            .font(.custom("나눔손글씨 둥근인연", size: 15))
                        Text("오늘의 할일을 추가 하는게 어떨까 😝")
                            .fontWeight(.semibold)
                            .font(.custom("나눔손글씨 둥근인연", size: 15))
                            .padding(.bottom , 80)
                            .overlay(
                                Button {
                                    taskModel.addNewTask.toggle()
                                } label: {
                                    Text("할일 추가 하러 가기 🥳")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(height: geometry.size.width / 8)
                                        .frame(maxWidth: .infinity)
                                        .background(animate ? ColorAsset.mainViewColor : ColorAsset.mainColor)
                                        .cornerRadius(12)
                                }
                                    .padding(.horizontal, animate ? 10 : 20)
                                    .shadow(color:  animate ? ColorAsset.mainColor.opacity(0.7) :
                                                ColorAsset.changeColor.opacity(0.7)
                                            , radius: animate ? 30 : 10,
                                            x: .zero,
                                            y:  animate ? 50 : 30 )
                                    .scaleEffect(animate ? 1.1 : 1.0)
                                    .offset(y: animate ? -7 : 0)
                                
                            )
                            .sheet(isPresented: $taskModel.addNewTask) {
                                // Clearing Edit Data
                                taskModel.editTask = nil
                            } content: {
                                AddNewTask()
                                    .environmentObject(taskModel)
                            }
                        
                    }
                    .frame(maxWidth: 400)
                    .multilineTextAlignment(.leading)
                    .padding(30)
                    .onAppear(perform: addAnimation)
                }
                .frame( maxWidth: .infinity, maxHeight: .infinity)
                
                
            } else {
                ForEach(request, id: \.objectID) { object in
                    self.content(object)
                }
            }
            
        }
    }
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation (
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever() ) {
                        animate.toggle()
                    }
        }
    }
}

