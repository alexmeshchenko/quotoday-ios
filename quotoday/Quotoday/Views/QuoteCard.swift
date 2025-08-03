//
//  QuoteCard.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// Карточка цитаты
struct QuoteCard: View {
    let quote: Quote
    let isBookmarked: Bool
    let onBookmarkToggle: () -> Void
    let onRefresh: () -> Void
    
    @State private var isRefreshing = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            // Текст цитаты
            Text("\"\(quote.text)\"")
                .font(.system(size: 20, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                //.frame(maxWidth: .infinity, minHeight: 200)
            
            // Автор
            if !quote.author.isEmpty {
                Text("— \(quote.author)")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.black.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 12)
            }
            
            // Кнопки внизу
            HStack {
                // Bookmark button
                Button(action: onBookmarkToggle) {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 22))
                        .foregroundColor(.black.opacity(0.7))
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // Refresh button
                Button(action: {
                    isRefreshing = true
                    onRefresh()
                    
                    // Сброс анимации через некоторое время
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isRefreshing = false
                    }
                }) {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                        .font(.system(size: 22))
                        .foregroundColor(.black.opacity(0.7))
                        .rotationEffect(.degrees(isRefreshing ? 360 : 0))
                        .animation(isRefreshing ? .linear(duration: 1).repeatForever(autoreverses: false) : .default, value: isRefreshing)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
        }
        .background(Color.appYellow)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Preview

struct QuoteCard_Previews: PreviewProvider {
    static var previews: some View {
        QuoteCard(
            quote: Quote(
                id: UUID(),
                text: "The only limit to our realization of tomorrow is our doubts of today.",
                author: "Franklin D. Roosevelt",
                category: "Motivation"
            ),
            isBookmarked: true,
            onBookmarkToggle: {},
            onRefresh: {}
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
