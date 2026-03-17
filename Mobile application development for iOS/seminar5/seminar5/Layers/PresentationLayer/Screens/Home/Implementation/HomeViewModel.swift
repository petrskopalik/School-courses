//
//  HomeViewModel.swift
//  seminar5
//
//  Created by Petr Skopalík on 17.03.2026.
//

final class HomeViewModel {
    
    let state = HomeViewState()
    
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository = TaskRepositoryImpl.shared) {
        self.taskRepository = taskRepository
    }
}
