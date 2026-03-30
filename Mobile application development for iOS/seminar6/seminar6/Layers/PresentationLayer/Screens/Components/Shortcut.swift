//
//  Shortcut.swift
//  seminar6
//
//  Created by Petr Skopalík on 30.03.2026.
//

import SwiftUI

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
