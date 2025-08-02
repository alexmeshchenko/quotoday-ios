//
//  MyQuoteCard.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// Карточка своей цитаты

struct MyQuoteCard: View {
    let quote: UserQuote
    @State private var isBookmarked = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quote.text)
                .font(.system(size: 16, weight: .medium))
            
            Text("- \(quote.author)")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            HStack {
                Button(action: { isBookmarked.toggle() }) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isBookmarked ? .yellow : .gray)
                }
                
                Spacer()
                
                Button(action: shareQuote) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 4)
            
            // Дата под карточкой
            Text(quote.createdAt, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 2)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    func shareQuote() {
        // Реализация шаринга
    }
}
