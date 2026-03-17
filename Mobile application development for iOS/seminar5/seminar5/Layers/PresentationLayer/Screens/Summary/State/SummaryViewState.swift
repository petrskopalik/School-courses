//
//  SummaryViewState.swift
//  seminar5
//
//  Created by Petr Skopalík on 17.03.2026.
//

import SwiftUI
import Foundation
internal import Combine

final class SummaryViewState: ObservableObject {
    @Published var tasks: [Task] = TaskRepositoryImpl.shared.tasks //do viewmodel ??
}
