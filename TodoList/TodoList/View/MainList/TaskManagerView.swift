//
//  TaskManagerView.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/08.
//

import SwiftUI

struct TaskManagerView: View {
    @StateObject var taskModel : TaskViewModel = TaskViewModel()
    var body: some View {
        ScrollView(.vertical , showsIndicators: false) {
            //MARK:  - Lazy vstack
            LazyVStack(spacing: 15 , pinnedViews: [.sectionHeaders]) {
                
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(taskModel.currentWeek, id: \.self){ day in
                                Text(day.formatted(date: .abbreviated, time: .omitted))
                            }
                        }
                    }
                    
                } header: {
                    headerViews()
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
