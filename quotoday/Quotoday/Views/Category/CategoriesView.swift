//
//  CategoriesView.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// Экран категорий
struct CategoriesView: View {
    @Environment(\.dismiss) var dismiss
    let selectedCategories: Set<String>
    let onSave: (Set<String>) -> Void
    
    // Временное состояние для выбранных категорий
    @State private var tempSelectedCategories: Set<String>
    
    init(selectedCategories: Set<String>, onSave: @escaping (Set<String>) -> Void) {
        self.selectedCategories = selectedCategories
        self.onSave = onSave
        // Инициализируем @State в init
        self._tempSelectedCategories = State(initialValue: selectedCategories)
    }
    
    let categories = [
            ("happiness", "😊"),
            ("business", "🤑"),
            ("life", "🌱"),
            ("love", "❤️"),
            ("success", "🏆"),
            ("inspirational", "✨")
        ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
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
                
                VStack(spacing: 12) {
                    ForEach(categories, id: \.0) { category in
                        CategoryButton(
                            title: category.0,
                            emoji: category.1,
                            isSelected: tempSelectedCategories.contains(category.0),
                            action: {
                                if tempSelectedCategories.contains(category.0) {
                                    tempSelectedCategories.remove(category.0)
                                } else {
                                    tempSelectedCategories.insert(category.0)
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
                
                Button(action: {
                    onSave(tempSelectedCategories)
                    dismiss()
                }) {
                    Text("done")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 120, height: 44)
                        .background(tempSelectedCategories.isEmpty ? Color.gray : Color.appGreen)
                        .cornerRadius(22)
                }
                .disabled(tempSelectedCategories.isEmpty)
                .opacity(tempSelectedCategories.isEmpty ? 0.6 : 1.0)
                .padding(.bottom, 40)
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
