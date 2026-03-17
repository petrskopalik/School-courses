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
    
    @State private var searchText: String = ""
    @State private var showAll: Bool = true
    @State private var showRepeating: Bool = false
    @State private var showNonRepeating: Bool = false
    @State private var filteredTasks: [Task]

    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("", selection: $showRepeating) {
                        Text("All").tag(false)
                        Text("Repeating").tag(true)
                    }
                    .pickerStyle(.segmented)
                }
                
                ForEach(filteredTasks) { task in
                    Text(task.title)
                }
            }
            .navigationTitle("Tasks")
            .searchable(text: $searchText, prompt: "Search tasks...")
            .onChange(of: searchText) { oldValue, newValue in
                viewModel.reloadData()
            }
        }
    }
}

#Preview {
    SummaryView.build()
}
