//
//  TaskViewModel.swift
//  TodoList
//
//  Created by 서원지 on 2022/08/08.
//

import Foundation
import SwiftUI

class TaskViewModel : ObservableObject {
    @Published var storedTasks: [TaskModel] = [
    
        TaskModel(taskTitle: "Meeting", taskDecription: "Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641645497)),
        TaskModel(taskTitle: "Icon set", taskDecription: "Edit icons for team task for next week", taskDate: .init(timeIntervalSince1970: 1641649097)),
        TaskModel(taskTitle: "Prototype", taskDecription: "Make and send prototype", taskDate: .init(timeIntervalSince1970: 1641652697)),
        TaskModel(taskTitle: "Check asset", taskDecription: "Start checking the assets", taskDate: .init(timeIntervalSince1970: 1641656297)),
        TaskModel(taskTitle: "Team party", taskDecription: "Make fun with team mates", taskDate: .init(timeIntervalSince1970: 1641661897)),
        TaskModel(taskTitle: "Client Meeting", taskDecription: "Explain project to clinet", taskDate: .init(timeIntervalSince1970: 1641641897)),
        TaskModel(taskTitle: "Next Project", taskDecription: "Discuss next project with team", taskDate: .init(timeIntervalSince1970: 1641677897)),
        TaskModel(taskTitle: "App Proposal", taskDecription: "Meet client for next App Proposal", taskDate: .init(timeIntervalSince1970: 1641681497)),
    ]
    
    //MARK:  - date
    @Published var currentWeek : [Date] = []
    //MARK:  Current Day
    @Published var currentDate: Date = Date()
    //MARK:  Filtering 날짜
    @Published var filteredTasks: [TaskModel]?
    init() {
        fetchCurrentWeek()
        filterTodayTask()
    }
  
    
    //MARK: - 일주일 날짜
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
    
    //MARK:  Filtering  날짜
    func filterTodayTask() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calender = Calendar.current
            let filltered = self.storedTasks.filter {
                return calender.isDate($0.taskDate, inSameDayAs: self.currentDate)
            }
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filltered
                }
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
    
    func isCurrentHour(date:Date) -> Bool {
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        let currentHour = calender.component(.hour, from: Date())
        return hour == currentHour
    }
}
