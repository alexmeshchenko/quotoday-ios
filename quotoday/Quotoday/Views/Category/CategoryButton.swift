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
            HStack {
                Text(emoji)
                    .font(.title2)
                Text(title)
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.appGreen : Color.gray.opacity(0.15))
            )
        }
    }
}
