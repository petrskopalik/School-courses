//
//  SummaryView.swift
//  seminar5
//
//  Created by Petr Skopalík on 15.03.2026.
//

import SwiftUI

struct SummaryView: View {
    @State private var searchText: String = ""
    @State private var showRepeating: Bool = false
    
    var filteredTasks: [Task] {
        TaskRepositoryImpl.shared.tasks
            .filter { !showRepeating || $0.isRepeatOn }
            .filter {
                searchText.isEmpty ||
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.subtitle.localizedCaseInsensitiveContains(searchText) ||
                $0.describtion.localizedCaseInsensitiveContains(searchText)
            }
    }
    
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
        }
    }
}

#Preview {
    SummaryView()
}
