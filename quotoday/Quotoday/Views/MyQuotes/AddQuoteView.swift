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
    @ObservedObject var viewModel: MyQuotesViewModel
    
    @State private var quoteText = ""
    @State private var authorText = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Quote")) {
                    TextEditor(text: $quoteText)
                        .frame(minHeight: 100)
                        .placeholder(when: quoteText.isEmpty) {
                            Text("Enter the quote text...")
                                .foregroundColor(.gray)
                        }
                }
                
                Section(header: Text("Author")) {
                    TextField("Author's name", text: $authorText)
                }
            }
            .navigationTitle("New quote")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveQuote()
                    }
                    .disabled(quoteText.isEmpty || authorText.isEmpty)
                }
            }
        }
    }
    
    func saveQuote() {
        viewModel.addQuote(
            text: quoteText.trimmingCharacters(in: .whitespacesAndNewlines),
            author: authorText.trimmingCharacters(in: .whitespacesAndNewlines))
        dismiss()
    }
}
