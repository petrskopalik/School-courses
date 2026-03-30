//
//  TaskDetailView.swift
//  seminar6
//
//  Created by Petr Skopalík on 30.03.2026.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    let task: Task
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop(color: task.categoryColor, location: 0.04),
                                Gradient.Stop(color: task.categoryColor.opacity(0.15), location: 0.04)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.largeTitle)
                            Text(task.subtitle)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        Image(systemName: task.iconName)
                            .font(.system(size: 40))
                    }
                    
                    Spacer()
                    
                    HStack {
                        if (!task.isRepeat){
                            VStack(alignment: .leading) {
                                Text("Start date")
                                    .foregroundStyle(.secondary)
                                Text(task.startDate.formatted(date: .abbreviated, time: .omitted))
                                    .bold()
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Frequency")
                                    .foregroundStyle(.secondary)
                                Text(task.frequency.rawValue)
                                    .bold()
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Times")
                                    .foregroundStyle(.secondary)
                                Text(task.times.codingKey.stringValue)
                                    .bold()
                            }
                            
                        } else {
                            VStack(alignment: .leading) {
                                Text("Due time")
                                    .foregroundStyle(.secondary)
                                Text(task.dueTime.formatted(date: .omitted, time: .shortened))
                                    .bold()
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Due date")
                                    .foregroundStyle(.secondary)
                                Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
                                    .bold()
                            }
                        }
                    }
                }
                .padding()
                .padding(.leading)
                .frame(width: 370, height: 200)
            }
            .frame(width: 370, height: 200)
            
            HStack {
                Text("Priority")
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                Text(task.priority.rawValue)
                    .font(.system(size: 25))
                    .fontWeight(.medium)
            }
            .padding()
            .frame(width: 370)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white.opacity(0.9))
            )
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Description")
                    .font(.title2)
                    .fontWeight(.medium)
                Text(task.description)
                    .font(.system(size: 20))
            }
            .padding()
            .frame(width: 370, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white.opacity(0.9))
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
    }
}
