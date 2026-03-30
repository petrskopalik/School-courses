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
            Tab("Tasks", systemImage: "list.star") {
                SummaryView.build()
            }
            Tab("Settings", systemImage: "slider.horizontal.3") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
