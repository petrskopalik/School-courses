//
//  HomeScreen.swift
//  seminar5
//
//  Created by Petr Skopalík on 17.03.2026.
//

extension HomeView {
    
    static func build() -> HomeView {
        let viewModel = HomeViewModel()
        return HomeView(state: viewModel.state,
                        viewModel: viewModel)
    }
}
