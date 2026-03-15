//
//  HomeView.swift
//  seminar5
//
//  Created by Petr Skopalík on 15.03.2026.
//

import SwiftUI

struct TaskView: View {
    let mainTitle: String
    let subTitle: String
    let threatLevel: String
    let date: String
    let iconName: String
    let type: String
    let typeColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            Gradient.Stop(color: typeColor, location: 0.04),
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
                        Image(systemName: iconName)
                            .foregroundStyle(Color.black)
                            .font(.system(size: 30))
                        VStack(alignment: .leading) {
                            Text(mainTitle)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(subTitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(threatLevel)
                            .foregroundStyle(Color.red)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                HStack{
                    VStack(alignment: .leading){
                        Text("Type")
                            .foregroundStyle(.secondary)
                        Text(type)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Due Date")
                            .foregroundStyle(.secondary)
                        Text(date)
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .frame(width: 350)
        }
    }
}

struct ShortCutView: View {
    let color: Color
    let status: String
    let iconName: String
    let count: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .shadow(radius: 3)
            VStack(alignment: .leading, spacing: 30){
                HStack(alignment: .center, spacing: 65){
                    Image(systemName: iconName)
                        .font(.system(size: 35))
                        .foregroundStyle(.white)
                    Text(count)
                        .font(.system(size: 35))
                        .foregroundStyle(Color.white)
                }
                Text(status)
                    .font(.title3)
                    .foregroundStyle(Color.white)
            }
        }
        .frame(width: 180, height: 125)
    }
}

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Tasks")
                .font(.title)
                .fontWeight(.bold)
            VStack(spacing: 15){
                TaskView(
                    mainTitle: "Finish Project Report",
                    subTitle: "Submit before meeting",
                    threatLevel: "!!!",
                    date: "Feb 25, 2026",
                    iconName: "text.document",
                    type: "One-time",
                    typeColor: Color.mint)
                TaskView(
                    mainTitle: "Gym Session",
                    subTitle: "Leg day",
                    threatLevel: "!",
                    date: "Feb 26, 2026",
                    iconName: "figure.run",
                    type: "Recurring",
                    typeColor: Color.myRed)
                TaskView(
                    mainTitle: "Prepare Lecture",
                    subTitle: "SwiftUI - State & Binding",
                    threatLevel: "!!!",
                    date: "Feb 25, 2026",
                    iconName: "graduationcap",
                    type: "Recurring",
                    typeColor: Color.myPurple)
            }
            Text("Shortcuts")
                .font(.title)
                .fontWeight(.bold)
            HStack(spacing: 10){
                ShortCutView(
                    color: Color.myPurple,
                    status: "Today",
                    iconName: "25.calendar",
                    count: "11")
                ShortCutView(
                    color: Color.myRed,
                    status: "Recurring",
                    iconName: "calendar",
                    count: "2")
            }
            HStack(spacing: 10){
                ShortCutView(
                    color: Color.myYellow,
                    status: "Flagged",
                    iconName: "flag",
                    count: "3")
                ShortCutView(
                    color: Color.myGreen,
                    status: "Completed",
                    iconName: "checkmark",
                    count: "5")
            }
        }
    }
}

#Preview {
    HomeView()
}
