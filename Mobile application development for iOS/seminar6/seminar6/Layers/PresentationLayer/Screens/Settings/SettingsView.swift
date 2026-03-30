//
//  SettingsView.swift
//  seminar6
//
//  Created by Petr Skopalík on 30.03.2026.
//

import SwiftUI

struct SettingsView: View {
    @State var isNotificationOn: Bool = false
    
    var body: some View {
        VStack {
            Button("Login") {
                print("Login")
            }
            .frame(width: 375, height: 60)
            .background(.blue)
            .foregroundStyle(.white)
            .font(.title)
            .bold()
            .cornerRadius(20)
            .padding(.top, 40)
            
            List {
                Toggle("Notifications on/off", isOn: $isNotificationOn)
            }
            .font(.system(size: 20))
        }
        .background(Color(.systemGray6))
    }
}

#Preview {
    SettingsView()
}
