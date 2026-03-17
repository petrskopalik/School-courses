//
//  SummaryViewModel.swift
//  seminar5
//
//  Created by Petr Skopalík on 17.03.2026.
//

//@State private var searchText: String = ""
//@State private var showAll: Bool = true
//@State private var showRepeating: Bool = false
//@State private var showNonRepeating: Bool = false
//
//let viewModel: SummaryViewModel
//@State private var filteredTasks: [Task]

import SwiftUI
internal import Combine

final class SummaryViewModel {
    @Published var searchText: String
    @Published var showAll: Bool
    @Published var showRepeating: Bool
    @Published var showNonRepeating: Bool
    @Published var filteredTasks: [Task]
    
    let state = SummaryViewState()
    
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository = TaskRepositoryImpl.shared) {
        searchText = ""
        showAll = true
        showRepeating = false
        showNonRepeating = false
        self.taskRepository = taskRepository
        filteredTasks = state.tasks
    }
    
    func reloadData() {
        
    }
}
