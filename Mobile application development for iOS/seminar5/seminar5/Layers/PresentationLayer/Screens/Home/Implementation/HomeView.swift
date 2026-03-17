//
//  HomeView.swift
//  seminar5
//
//  Created by Petr Skopalík on 15.03.2026.
//

import SwiftUI

struct TaskView: View {
    let task: Task
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            Gradient.Stop(color: task.categoryColor, location: 0.04),
                            Gradient.Stop(color: Color(white: 0.97), location: 0.04)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 370, height: 140)
                .shadow(radius: 4)
            VStack(spacing: 15){
                HStack{
                    HStack(alignment: .center) {
                        Image(systemName: task.iconName)
                            .foregroundStyle(Color.black)
                            .font(.system(size: 30))
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(task.subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(task.priority.rawValue)
                            .foregroundStyle(Color.red)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                HStack{
                    VStack(alignment: .leading){
                        Text("Type")
                            .foregroundStyle(.secondary)
                        Text(task.category.rawValue)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Due Date")
                            .foregroundStyle(.secondary)
                        Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .frame(width: 350)
        }
    }
}

struct ShortcutView: View {
    let shortcut: Shortcut
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(shortcut.categoryColor)
                .shadow(radius: 3)
            VStack(alignment: .leading, spacing: 30){
                HStack(alignment: .center, spacing: 65){
                    Image(systemName: shortcut.iconName)
                        .font(.system(size: 35))
                        .foregroundStyle(.white)
                    Text(String(shortcut.count))
                        .font(.system(size: 35))
                        .foregroundStyle(Color.white)
                }
                Text(shortcut.category.rawValue)
                    .font(.title3)
                    .foregroundStyle(Color.white)
            }
        }
        .frame(width: 180, height: 125)
    }
}

struct HomeView: View {
    @ObservedObject var state: HomeViewState
    let viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10){
                Text("Tasks")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 15){
                        ForEach(viewModel.state.tasks) {
                            task in TaskView(task: task)
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

#Preview {
    HomeView.build()
}
