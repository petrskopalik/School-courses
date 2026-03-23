//
//  SummaryView.swift
//  seminar5
//
//  Created by Petr Skopalík on 15.03.2026.
//

import SwiftUI
internal import Combine

struct SummaryView: View {
    @ObservedObject var state: SummaryViewState
    let viewModel: SummaryViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("", selection: $state.searchFilter) {
                    ForEach(SearchFilter.allCases, id: \.self) {
                        filter in Text(filter.title).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: state.searchFilter) { oldValue, newValue in
                    viewModel.reloadData()
                }
                
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(state.filteredTasks) { task in
                            TaskView(task: task)
                        }
                    }
                }
                .padding(.top, 10)
                
                .navigationTitle("Tasks")
                .searchable(text: $state.searchText, placement: .navigationBarDrawer, prompt: "Search tasks...")
                .onChange(of: state.searchText) { oldValue, newValue in
                    viewModel.reloadData()
                }
            }
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    SummaryView.build()
}
