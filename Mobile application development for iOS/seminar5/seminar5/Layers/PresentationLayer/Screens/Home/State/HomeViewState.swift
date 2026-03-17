//
//  HomeViewState.swift
//  seminar5
//
//  Created by Petr Skopalík on 17.03.2026.
//

import SwiftUI
import Foundation
internal import Combine

final class HomeViewState: ObservableObject {
    @Published var tasks: [Task] = TaskRepositoryImpl.shared.tasks
    @Published var shortcuts: [Shortcut] = [
        Shortcut(
            category: .Today,
            categoryColor: Color.myPurple,
            iconName: "25.calendar",
            count: 11),
        Shortcut(
            category: .Recurring,
            categoryColor: Color.myRed,
            iconName: "calendar",
            count: 2),
        Shortcut(
            category: .Flagged,
            categoryColor: Color.myYellow,
            iconName: "flag",
            count: 4),
        Shortcut(
            category: .Completed,
            categoryColor: Color.myGreen,
            iconName: "checkmark",
            count: 5)
    ]
}
