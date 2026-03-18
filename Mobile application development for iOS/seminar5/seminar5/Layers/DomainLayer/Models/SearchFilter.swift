//
//  SearchFilter.swift
//  seminar5
//
//  Created by Petr Skopalík on 18.03.2026.
//

enum SearchFilter: CaseIterable{
    case All
    case Repeat
    case NonRepeat
    
    var title: String {
        switch self {
        case .All: return "All"
        case .Repeat: return "Repeat"
        case .NonRepeat: return "NonRepeat"
        }
    }
    
    func match(_ task: Task) -> Bool {
        switch self {
        case .All: return true
        case .Repeat: return task.isRepeat
        case .NonRepeat: return !task.isRepeat
        }
    }
}
