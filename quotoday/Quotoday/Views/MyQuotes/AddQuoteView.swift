//
//  AddQuoteView.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// AddQuoteView
//  экран добавления новой цитаты

// MARK: - Add Quote View
struct AddQuoteView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MyQuotesViewModel
    
    @State private var quoteText = ""
    @State private var authorText = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Цитата")) {
                    TextEditor(text: $quoteText)
                        .frame(minHeight: 100)
                        .placeholder(when: quoteText.isEmpty) {
                            Text("Введите текст цитаты...")
                                .foregroundColor(.gray)
                        }
                }
                
                Section(header: Text("Автор")) {
                    TextField("Имя автора", text: $authorText)
                }
            }
            .navigationTitle("Новая цитата")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        saveQuote()
                    }
                    .disabled(quoteText.isEmpty || authorText.isEmpty)
                }
            }
            .alert("Успешно!", isPresented: $showAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Цитата успешно добавлена")
            }
        }
    }
    
    func saveQuote() {
        viewModel.addQuote(text: quoteText.trimmingCharacters(in: .whitespacesAndNewlines),
                          author: authorText.trimmingCharacters(in: .whitespacesAndNewlines))
        showAlert = true
    }
}
