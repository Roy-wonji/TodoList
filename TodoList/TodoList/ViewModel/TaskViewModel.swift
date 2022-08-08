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
    
    //MARK:  Current Day
    @Published var currentDate: Date = Date()
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
            if let weekday = calender.date(byAdding: .day, value: day ,to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    //MARK: Dateformatter
    func extractDate(date: Date, format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    //MARK: 날짜 확인
    func isToday(date: Date) -> Bool {
        let calender = Calendar.current
        
        return calender.isDate(currentDate, inSameDayAs: date)
    }
}
