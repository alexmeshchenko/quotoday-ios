//
//  CategoriesView.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI
// MARK: - CategoriesView
struct CategoriesView: View {
    @Environment(\.dismiss) var dismiss
    let selectedThemes: Set<QuoteTheme>
    let onSave: (Set<QuoteTheme>) -> Void
    
    @State private var tempSelectedThemes: Set<QuoteTheme>
    
    init(selectedThemes: Set<QuoteTheme>, onSave: @escaping (Set<QuoteTheme>) -> Void) {
        self.selectedThemes = selectedThemes
        self.onSave = onSave
        self._tempSelectedThemes = State(initialValue: selectedThemes)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Заголовок
                VStack(spacing: 8) {
                    Text("What makes you")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("feel that way?")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top, 20)
                
                Text("you can select more than one")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Список тем
                VStack(spacing: 12) {
                    ForEach(QuoteTheme.allCases) { theme in
                        CategoryButton(
                            title: theme.displayName,
                            emoji: theme.emoji,
                            isSelected: tempSelectedThemes.contains(theme),
                            action: {
                                if tempSelectedThemes.contains(theme) {
                                    tempSelectedThemes.remove(theme)
                                } else {
                                    tempSelectedThemes.insert(theme)
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text("you can change it later")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Кнопка "Done"
                Button(action: {
                    onSave(tempSelectedThemes)
                    dismiss()
                }) {
                    Text("done")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 120, height: 44)
                        .background(tempSelectedThemes.isEmpty ? Color.gray : Color.appGreen)
                        .cornerRadius(22)
                }
                .disabled(tempSelectedThemes.isEmpty)
                .opacity(tempSelectedThemes.isEmpty ? 0.6 : 1.0)
                .padding(.bottom, 40)
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
