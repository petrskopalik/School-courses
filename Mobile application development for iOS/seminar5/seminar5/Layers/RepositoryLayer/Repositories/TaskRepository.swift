//
//  TaskRepository.swift
//  seminar5
//
//  Created by Petr Skopalík on 16.03.2026.
//

import SwiftUI

protocol TaskRepository {
    
    var tasks: [Task] { get }
    func addTask(new task: Task)
    func removeTask(id: Int)
}

func makeDate(_ year: Int, _ month: Int, _ day: Int) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}

func makeTime(_ hour: Int, _ minute: Int) -> Date {
    Calendar.current.date(from: DateComponents(hour: hour, minute: minute)) ?? Date()
}

final class TaskRepositoryImpl: TaskRepository {
    
    static let shared: TaskRepositoryImpl = TaskRepositoryImpl()
    
    private(set) var tasks: [Task] = [
        Task(id: 1,
             title: "Sprint Planning",
             subtitle: "Q2 kickoff meeting",
             describtion: "Plan all tasks and assign story points for the upcoming sprint with the team.",
             dueDate: makeDate(2026, 3, 18),
             dueTime: makeTime(9, 0),
             frequency: .Weekly,
             startDate: makeDate(2026, 3, 18),
             times: 4,
             priority: .High,
             category: .Work,
             iconName: "briefcase",
             categoryColor: Color.blue,
             isRepeatOn: true),
        
        Task(id: 2,
             title: "Morning Yoga",
             subtitle: "15 min stretch routine",
             describtion: "Start the day with a short yoga and breathing session to improve focus.",
             dueDate: makeDate(2026, 3, 17),
             dueTime: makeTime(7, 0),
             frequency: .Daily,
             startDate: makeDate(2026, 3, 1),
             times: 30,
             priority: .Low,
             category: .Recurring,
             iconName: "figure.mind.and.body",
             categoryColor: Color.myRed,
             isRepeatOn: true),

        Task(id: 3,
             title: "Fix Auth Bug",
             subtitle: "Token refresh crash",
             describtion: "Investigate and fix the crash occurring during token refresh on background fetch.",
             dueDate: makeDate(2026, 3, 19),
             dueTime: makeTime(11, 30),
             frequency: .Daily,
             startDate: makeDate(2026, 3, 17),
             times: 0,
             priority: .High,
             category: .Work,
             iconName: "wrench.and.screwdriver",
             categoryColor: Color.blue,
             isRepeatOn: false),

        Task(id: 4,
             title: "Buy Groceries",
             subtitle: "Weekly shopping",
             describtion: "Pick up vegetables, fruit, dairy and snacks for the week.",
             dueDate: makeDate(2026, 3, 17),
             dueTime: makeTime(17, 0),
             frequency: .Daily,
             startDate: makeDate(2026, 3, 17),
             times: 1,
             priority: .Medium,
             category: .Today,
             iconName: "cart",
             categoryColor: Color.pink,
             isRepeatOn: false),

        Task(id: 5,
             title: "Read WWDC Notes",
             subtitle: "SwiftUI sessions",
             describtion: "Go through saved WWDC session notes and highlight key SwiftUI updates.",
             dueDate: makeDate(2026, 3, 22),
             dueTime: makeTime(20, 0),
             frequency: .Weekly,
             startDate: makeDate(2026, 3, 17),
             times: 8,
             priority: .Low,
             category: .Flagged,
             iconName: "bookmark",
             categoryColor: Color.myYellow,
             isRepeatOn: true),

        Task(id: 6,
             title: "Dentist Appointment",
             subtitle: "Annual checkup",
             describtion: "Routine dental checkup and cleaning at the clinic.",
             dueDate: makeDate(2026, 3, 25),
             dueTime: makeTime(14, 0),
             frequency: .Monthly,
             startDate: makeDate(2026, 3, 25),
             times: 1,
             priority: .Medium,
             category: .Today,
             iconName: "cross.case",
             categoryColor: Color.myPurple,
             isRepeatOn: true),

        Task(id: 7,
             title: "Refactor ViewModel",
             subtitle: "TaskListViewModel cleanup",
             describtion: "Extract business logic from the view, apply MVVM properly and add unit tests.",
             dueDate: makeDate(2026, 3, 20),
             dueTime: makeTime(10, 0),
             frequency: .Daily,
             startDate: makeDate(2026, 3, 18),
             times: 3,
             priority: .High,
             category: .Work,
             iconName: "chevron.left.forwardslash.chevron.right",
             categoryColor: Color.blue,
             isRepeatOn: true),

        Task(id: 8,
             title: "Evening Run",
             subtitle: "5km around the park",
             describtion: "Keep up the weekly running habit to maintain fitness and clear the mind.",
             dueDate: makeDate(2026, 3, 18),
             dueTime: makeTime(18, 30),
             frequency: .Weekly,
             startDate: makeDate(2026, 1, 1),
             times: 52,
             priority: .Medium,
             category: .Recurring,
             iconName: "figure.run",
             categoryColor: Color.myRed,
             isRepeatOn: true),

        Task(id: 9,
             title: "Submit Tax Return",
             subtitle: "Deadline: March 31",
             describtion: "Gather all income documents and submit the annual tax return online.",
             dueDate: makeDate(2026, 3, 31),
             dueTime: makeTime(12, 0),
             frequency: .Daily,
             startDate: makeDate(2026, 3, 17),
             times: 1,
             priority: .High,
             category: .Flagged,
             iconName: "eurosign.bank.building",
             categoryColor: Color.myYellow,
             isRepeatOn: true),

        Task(id: 10,
             title: "Finish SwiftUI Course",
             subtitle: "Last 3 modules",
             describtion: "Complete the remaining modules on animations and custom transitions.",
             dueDate: makeDate(2026, 4, 1),
             dueTime: makeTime(21, 0),
             frequency: .Daily,
             startDate: makeDate(2026, 3, 17),
             times: 15,
             priority: .Medium,
             category: .Completed,
             iconName: "checkmark.seal",
             categoryColor: Color.myGreen,
             isRepeatOn: true)
    ]
    
    func addTask(new task: Task) {
        tasks.append(task)
    }
    
    func removeTask(id: Int) {
        tasks.removeAll(where: { $0.id == id })
    }
}
