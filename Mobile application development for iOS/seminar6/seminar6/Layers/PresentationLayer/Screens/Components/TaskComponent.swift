//
//  TaskView.swift
//  seminar6
//
//  Created by Petr Skopalík on 30.03.2026.
//

import SwiftUI

struct TaskComponent: View {
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
