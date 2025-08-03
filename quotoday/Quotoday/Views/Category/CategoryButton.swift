//
//  CategoryButton.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// MARK: - CategoryButton
struct CategoryButton: View {
    let title: String
    let emoji: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(emoji)
                    .font(.title2)
                Text(title.capitalized)
                    .font(.system(size: 16, weight: .medium))
                Spacer()
            }
            .foregroundColor(isSelected ? .black : .primary)
        }
        .padding(.horizontal, 20)
        .frame(height: 44)
        .background(isSelected
                    ? Color.appGreen
                    : (isSelected ? Color.appGreen : Color.gray.opacity(0.15)))
        .cornerRadius(22)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}
