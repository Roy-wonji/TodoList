//
//  TaskViewModel.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/08.
//

import Foundation

class TaskViewModel : ObservableObject {
    @Published var storedTasks: [TaskModel] = [
    
        TaskModel(taskTitle: "업데이트 하기", taskDecription: "1.01 ui 업데이트 및  사진 수정", taskDate: .init(timeIntervalSince1970: 20220806)),
        TaskModel(taskTitle: "업데이트 ", taskDecription: "1.01 ui 업데이트 및  사진 수정", taskDate: .init(timeIntervalSince1970: 20220806)),
        TaskModel(taskTitle: "업데이트 하기", taskDecription: "1.01 ui 업데이트 및  사진 수정", taskDate: .init(timeIntervalSince1970: 20220806)),
        TaskModel(taskTitle: "업데이트 하기", taskDecription: "1.01 ui 업데이트 및  사진 수정", taskDate: .init(timeIntervalSince1970: 20220806)),
        TaskModel(taskTitle: "업데이트 하기", taskDecription: "1.01 ui 업데이트 및  사진 수정", taskDate: .init(timeIntervalSince1970: 20220806)),
        TaskModel(taskTitle: "업데이트 하기", taskDecription: "1.01 ui 업데이트 및  사진 수정", taskDate: .init(timeIntervalSince1970: 20220806)),
        TaskModel(taskTitle: "업데이트 하기", taskDecription: "1.01 ui 업데이트 및  사진 수정", taskDate: .init(timeIntervalSince1970: 20220806)),
        
    ]
    
    //MARK:  - date
    @Published var currentWeek : [Date] = []
    init() {
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let calender = Calendar.current
        
        let week = calender.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else { return}
        
        let weekend: ClosedRange<Int> = 1...7
        (weekend).forEach { day in
            if let weekday = calender.date(bySetting: .day, value: day, of: firstWeekDay) {
                currentWeek.append(weekday)
            }
             
        }
    }
    
    
}
