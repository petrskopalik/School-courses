//
//  CreateTaskView.swift
//  seminar5
//
//  Created by Petr Skopalík on 15.03.2026.
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
                .padding(.leading, 10)
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

struct OnRepeat: View {
    @Binding var isRepeatOn: Bool
    @Binding var frequency: Frequency
    @Binding var startDate: Date
    @Binding var times: Int
//    @Binding var dueTime: Date
    
    func incrementStep() {
        times += 1
    }

    func decrementStep() {
        times -= 1
        if times < 1 {times = 0}
    }
    
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
                DatePicker("Start date",
                           selection: $startDate,
                           displayedComponents: .date)
                    .font(.system(size: 20))
//                DatePicker("Time",
//                           selection: $dueTime,
//                           displayedComponents: .hourAndMinute)
                Picker("Frequency", selection: $frequency) {
                    ForEach(Frequency.allCases, id: \.self) { f in
                        Text(f.rawValue)
                    }
                }
                HStack {
                    Text("Times: ")
                    Stepper {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemGray6))
                            TextField(
                                "",
                                value: $times,
                                formatter: NumberFormatter()
                            )
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                        }
                        .frame(width: 75)
                    } onIncrement: {
                        incrementStep()
                    } onDecrement: {
                        decrementStep()
                    }
                }
            }
            .font(.system(size: 20))
            .frame(height: 265)
            .padding(.top, -35)
            .scrollContentBackground(.hidden)
        }
        .scrollDisabled(true)
    }
}

struct OffReapeat: View {
    @Binding var isRepeatOn: Bool
    @Binding var dueDate: Date
    @Binding var dueTime: Date
    
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
        .scrollDisabled(true)
    }
}

struct DateSettings: View {
    @State private var isRepeatOn: Bool = false
    @State private var dueDate: Date = Date()
    @State private var dueTime: Date = Date()
    @State private var frequency: Frequency = Frequency.Daily
    @State private var startDate: Date = Date()
    @State private var times: Int = 0
    
    var body: some View {
        if (isRepeatOn){
            OnRepeat(isRepeatOn: $isRepeatOn, frequency: $frequency, startDate: $startDate, times: $times)
        }
        else {
            OffReapeat(isRepeatOn: $isRepeatOn, dueDate: $dueDate, dueTime: $dueTime)
        }
    }
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
        .scrollDisabled(true)
    }
}

struct CreateTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                VStack {
                    HStack {
                        Spacer()
                        Button("", systemImage: "xmark.circle") {
                            dismiss()
                        }
                        .font(.system(size: 40))
                        .tint(.red)
                    }
                    .padding(.horizontal)
                    
                    TaskDetails()
                    DateSettings()
                    AditionalSettings()
                    
                    Spacer()

                    Button("Save") {
                        print("Uloženo")
                    }
                    .frame(width: 375, height: 60)
                    .background(.myGreen)
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
                    .cornerRadius(20)
                }
            }
        }
        .background(Color(.systemGray6))
    }
}

#Preview {
    CreateTaskView()
}
