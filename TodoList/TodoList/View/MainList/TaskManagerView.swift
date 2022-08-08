//
//  TaskManagerView.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/08.
//

import SwiftUI

struct TaskManagerView: View {
    @StateObject var taskModel : TaskViewModel = TaskViewModel()
    @Namespace var animation
    var body: some View {
//        GeometryReader{ geometry in
            ScrollView(.vertical , showsIndicators: false) {
                //MARK:  - Lazy vstack
                LazyVStack(spacing: 15 , pinnedViews: [.sectionHeaders]) {
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(taskModel.currentWeek, id: \.self){ day in
                                    VStack(spacing: 10) {
                                        Text(taskModel.extractDate(date: day, format: "dd"))
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                        Text(taskModel.extractDate(date: day, format: "EEE"))
                                            .font(.system(size: 14))
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 8, height: 8)
                                            .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                    }
                                    .foregroundStyle(taskModel.isToday(date: day) ? .primary : .tertiary)
                                    .foregroundColor(taskModel.isToday(date: day) ?  .white : .black)
                                    .frame(width: 45  , height:  90 )
                                    .background(
                                        
                                        ZStack {
                                            if taskModel.isToday(date: day){
                                                Capsule()
                                                    .fill(ColorAsset.fontColor)
                                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                            }
                                        }
                                        
                                    )
                                    .containerShape(Capsule())
                                    .onTapGesture {
                                        withAnimation {
                                            taskModel.currentDate = day
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        taskView()
                    } header: {
                        headerViews()
                    }
                }
                .frame( maxWidth: .infinity, maxHeight: .infinity)
            }
    }
      @ViewBuilder
    func taskView() ->some View {
        LazyVStack(spacing:25){
            if let tasks = taskModel.filteredTasks {
                if tasks.isEmpty {
                    Text("No tasks found!!")
                        .font(.system(size: 15))
                        .fontWeight(.light)
                        .offset(y: 100)
                }else{
                    ForEach(tasks){ task in
                        taskCardView(task: task)
                    }
                }
            }else{
                ProgressView().offset(x: 100)
            }
        }
        .padding()
        .padding(.top)
        .onChange(of: taskModel.currentDate) { newValue in
            taskModel.filterTodayTask()
        }
    }
    
    @ViewBuilder
    func taskCardView(task: TaskModel) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack {
                Circle().fill(taskModel.isCurrentHour(date: task.taskDate) ?  ColorAsset.fontColor :  .clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black,lineWidth: 1)
                            .padding(-3)
                    )
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack (alignment: .leading, spacing: 12) {
                        Text(task.taskTitle).font(.title2.bold())
                        Text(task.taskDecription).font(.caption).foregroundStyle(.secondary)
                    }.hLeading()
                    Text(task.taskDate.formatted(date: .omitted, time: .shortened))
                }
                
                if (taskModel.isCurrentHour(date: task.taskDate)) {
                    HStack(spacing:0) {
                        HStack(spacing:-10) {
                            ForEach(["user1","user2","user3"], id:\.self){ user in
                                Image(user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .background(
                                        Circle().stroke(.black,lineWidth: 5)
                                    )
                            }
                        }.hLeading()
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark").foregroundStyle(.black).padding(10).background(Color.white,in: RoundedRectangle(cornerRadius:10))
                        }
                    }.padding(10)
                }
                
            }.foregroundColor(taskModel.isCurrentHour(date: task.taskDate) ? .white : .black)
                .padding(taskModel.isCurrentHour(date: task.taskDate) ? 15 : 0)
                .padding(.bottom,taskModel.isCurrentHour(date: task.taskDate) ? 0 : 10)
                .hLeading()
                .background(
                    Color("MainColor").cornerRadius(25).opacity(taskModel.isCurrentHour(date: task.taskDate) ? 1 : 0)
                )
        }.hLeading()
    }
        func headerViews() ->some View {
            HStack(spacing: 20 ) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(ColorAsset.fontColor)
                    Text("Today")
                        .font(.largeTitle.bold())
                }
                .hLeading()
            }
            .padding()
        }
    }
    
    struct TaskManagerView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                TaskManagerView()
                    .navigationBarHidden(true)
            }
        }
    }
