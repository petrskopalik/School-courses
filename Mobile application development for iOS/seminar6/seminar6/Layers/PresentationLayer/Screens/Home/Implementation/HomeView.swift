//
//  HomeView.swift
//  seminar5
//
//  Created by Petr Skopalík on 15.03.2026.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var state: HomeViewState
    let viewModel: HomeViewModel
    
    @State var showAddTask: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10){
                    HStack(alignment: .center) {
                        Text("Tasks")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button("", systemImage: "plus"){
                            showAddTask.toggle()
                        }
                        .font(.system(size: 40))
                        .tint(.black)
                        .fullScreenCover(isPresented: $showAddTask) {
                            CreateTaskView()
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: 15){
                            ForEach(viewModel.state.tasks) { task in
                                NavigationLink(destination: TaskDetailView(task: task)) {
                                    TaskComponent(task: task)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .frame(height: 455)
                    
                    Text("Shortcuts")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    HStack(spacing: 10){
                        ShortcutView(shortcut: Shortcut(
                            category: .Today,
                            categoryColor: Color.myPurple,
                            iconName: "25.calendar",
                            count: 11)
                        )
                        ShortcutView(shortcut: Shortcut(
                            category: .Recurring,
                            categoryColor: Color.myRed,
                            iconName: "calendar",
                            count: 2)
                        )
                    }
                    .padding(.horizontal)
                    HStack(spacing: 10){
                        ShortcutView(shortcut: Shortcut(
                            category: .Flagged,
                            categoryColor: Color.myYellow,
                            iconName: "flag",
                            count: 4)
                        )
                        ShortcutView(shortcut: Shortcut(
                            category: .Completed,
                            categoryColor: Color.myGreen,
                            iconName: "checkmark",
                            count: 5)
                        )
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    HomeView.build()
}
