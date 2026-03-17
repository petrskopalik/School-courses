//
//  ContentView.swift
//  seminar5
//
//  Created by Petr Skopalík on 15.03.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            Tab("Home", systemImage: "house") {
                HomeView.build()
            }
            Tab("Summary", systemImage: "list.star") {
                SummaryView()
            }
            Tab("New Task", systemImage: "square.and.pencil") {
                CreateTaskView()
            }
        }
    }
}

#Preview {
    ContentView()
}
