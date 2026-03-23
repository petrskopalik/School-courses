//
//  SummaryViewModel.swift
//  seminar5
//
//  Created by Petr Skopalík on 17.03.2026.
//

import SwiftUI
internal import Combine

final class SummaryViewModel {
    
    let state = SummaryViewState()
    
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository = TaskRepositoryImpl.shared) {
        self.taskRepository = taskRepository
        state.filteredTasks = taskRepository.tasks
    }
    
    func reloadData() {
        state.filteredTasks = taskRepository.tasks
            .filter { state.searchFilter.match($0) }
            .filter {
                state.searchText.isEmpty ||
                $0.title.localizedCaseInsensitiveContains(state.searchText) ||
                $0.subtitle.localizedCaseInsensitiveContains(state.searchText) ||
                $0.description.localizedCaseInsensitiveContains(state.searchText)
            }
    }
}
