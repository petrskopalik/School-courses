//
//  ContentView.swift
//  seminar4
//
//  Created by Petr Skopalík on 09.03.2026.
//

import SwiftUI

struct TaskDetails: View {
    @State private var title: String = ""
    @State private var subtitle: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Basic Information")
                .font(.headline)
                .foregroundStyle(.darkGrey)
                .frame(alignment: .leading)
                .padding([.leading, .top], 10)
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                VStack(spacing: 10) {
                    TextField(
                        "Title",
                        text: $title
                    )
                    Divider()
                    TextField(
                        "Subtitle",
                        text: $subtitle
                    )
                    Divider()
                    TextField(
                        "Description",
                        text: $description
                    )
                    .frame(height: 80, alignment: .top)
                }
                .padding()
                .textFieldStyle(.plain)
                .font(.system(size: 20))
            }
        }
        .frame(width: 375, height: 250)
    }
}

enum Frequency: String, CaseIterable, Identifiable {
    case Hourly = "Hourly"
    case Daily = "Daily"
    case Weekly = "Weekly"
    case Monthly = "Monthly"
    var id: Self {self}
}

struct OnRepeat: View {
    @Binding var isRepeatOn: Bool
    @Binding var frequency: Frequency
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var times: String
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("Date & Time")
                .font(.headline)
                .foregroundStyle(.darkGrey)
                .padding(.leading, 25)
                .padding(.top, 10)
                .frame(alignment: .leading)
            List {
                Toggle("Repeat", isOn: $isRepeatOn)
                Picker("Frequency", selection: $frequency) {
                    ForEach(Frequency.allCases, id: \.self) { f in
                        Text(f.rawValue)
                    }
                }
                DatePicker("Start",
                           selection: $startDate,
                           displayedComponents: .date)
                    .font(.system(size: 20))
                TextField(
                    "Times",
                    text: $times
                )
                .keyboardType(.numberPad)
            }
            .font(.system(size: 20))
            .frame(height: 260)
            .padding(.top, -35)
            .scrollContentBackground(.hidden)
        }
    }
}

struct OffReapeat: View {
    @Binding var isRepeatOn: Bool
    @Binding var dueDate: Date
    @Binding var dueTime: Date
    // some change
    var body: some View {
        VStack(alignment: .leading) {
            Text("Date & Time")
                .font(.headline)
                .foregroundStyle(.darkGrey)
                .padding(.leading, 25)
                .padding(.top, 10)
                .frame(alignment: .leading)
            List {
                Toggle("Repeat", isOn: $isRepeatOn)
                DatePicker("Date",
                           selection: $dueDate,
                           displayedComponents: .date)
                DatePicker("Time",
                           selection: $dueTime,
                           displayedComponents: .hourAndMinute)
            }
            .font(.system(size: 20))
            .frame(height: 220)
            .padding(.top, -35)
            .scrollContentBackground(.hidden)
        }
    }
}

struct DateSettings: View {
    @State private var isRepeatOn: Bool = false
    @State private var dueDate: Date = Date()
    @State private var dueTime: Date = Date()
    @State private var frequency: Frequency = Frequency.Daily
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var times: String = ""
    
    var body: some View {
        if (isRepeatOn){
            OnRepeat(isRepeatOn: $isRepeatOn, frequency: $frequency, startDate: $startDate, endDate: $endDate, times: $times)
        }
        else {
            OffReapeat(isRepeatOn: $isRepeatOn, dueDate: $dueDate, dueTime: $dueTime)
        }
    }
}

enum Priority: String, CaseIterable, Identifiable {
    case Low = "Low"
    case Medium = "Medium"
    case High = "High"
    var id: Self {self}
}

enum Category: String, CaseIterable, Identifiable {
    case Work = "Work"
    case Completed = "Completed"
    case Today = "Today"
    case Recurring = "Recurring"
    case Flasgged = "Flagged"
    var id: Self {self}
}

struct AditionalSettings: View {
    @State private var priority: Priority = Priority.Low
    @State private var category: Category = Category.Work
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Aditional Settings")
                    .font(.headline)
                    .foregroundStyle(.darkGrey)
                    .padding([.leading, .top], 10)
                    .frame(width: 375, alignment: .leading)
            }
            List {
                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) { p in
                        Text(p.rawValue)
                    }
                }
                Picker("Category", selection: $category) {
                    ForEach(Category.allCases, id: \.self) { c in
                        Text(c.rawValue)
                    }
                }
            }
            .font(.system(size: 20))
            .frame(height: 150)
            .padding(.top, -30)
            .scrollContentBackground(.hidden)
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemGray6)
                .ignoresSafeArea()
            VStack {
                TaskDetails()
                DateSettings()
                AditionalSettings()
                
                Spacer()

                Button("Save") {
                    print("Uloženo")
                }
                .frame(width: 375, height: 60)
                .background(.blue)
                .foregroundStyle(.white)
                .font(.title)
                .bold()
                .cornerRadius(20)
            }
        }
    }
}

#Preview {
    ContentView()
}
