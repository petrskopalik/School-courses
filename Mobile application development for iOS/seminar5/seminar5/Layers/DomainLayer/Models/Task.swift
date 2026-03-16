//
//  Task.swift
//  seminar5
//
//  Created by Petr Skopalík on 16.03.2026.
//

import SwiftUI

enum Priority: String, CaseIterable, Identifiable {
    case Low = "Low"
    case Medium = "Medium"
    case High = "High"
    var id: Self {self}
}

enum Category: String, CaseIterable, Identifiable {
    case Work = "Work"
    case Completed = "Completed"
    case Today = "Today"
    case Recurring = "Recurring"
    case Flagged = "Flagged"
    var id: Self {self}
}

enum Frequency: String, CaseIterable, Identifiable {
    case Hourly = "Hourly"
    case Daily = "Daily"
    case Weekly = "Weekly"
    case Monthly = "Monthly"
    var id: Self {self}
}

struct Task: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let describtion: String
    let dueDate: Date
    let dueTime: Date
    let frequency: Frequency
    let startDate: Date
    let times: Int
    let priority: Priority
    let category: Category
    let iconName: String
    let categoryColor: Color
    let isRepeatOn: Bool
}
