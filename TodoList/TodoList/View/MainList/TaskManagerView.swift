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
        GeometryReader{ geometry in
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
                                    .frame(width: (geometry.size.width / 8.5) , height: geometry.size.height / 7)
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
                                    //MARK: - 날짜 이동
                                    .onTapGesture {
                                        withAnimation {
                                            taskModel.currentDate = day
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                    } header: {
                        headerViews()
                    }
                }
            }
        }
    }
    
    func headerViews() -> some View {
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
        TaskManagerView()
    }
}
