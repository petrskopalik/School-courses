//
//  SummaryScreen.swift
//  seminar5
//
//  Created by Petr Skopalík on 17.03.2026.
//

extension SummaryView {
    
    static func build() -> SummaryView {
        let viewModel = SummaryViewModel()
        return SummaryView(state: viewModel.state,
                           viewModel: viewModel)
    }
}
