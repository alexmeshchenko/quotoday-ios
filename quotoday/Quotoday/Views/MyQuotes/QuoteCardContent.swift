//
//  QuoteCardContent.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import SwiftUI

// MARK: - QuoteCardContent (основная карточка)
struct QuoteCardContent: View {
    let quote: UserQuote
    @ObservedObject var viewModel: MyQuotesViewModel
    @State private var isBookmarked: Bool
    
    init(quote: UserQuote, viewModel: MyQuotesViewModel) {
        self.quote = quote
        self.viewModel = viewModel
        self._isBookmarked = State(initialValue: quote.isBookmarked)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Текст цитаты
            Text(quote.text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            
            // Автор
            Text("- \(quote.author)")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            // Кнопки действий
            QuoteActionButtons(
                isBookmarked: $isBookmarked,
                onBookmarkToggle: {
                    viewModel.toggleBookmark(for: quote)
                },
                onShare: {
                    shareQuote()
                }
            )
            .padding(.top, 4)
            
            // Дата
            Text(quote.createdAt, formatter: dateFormatter)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 2)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private func shareQuote() {
        let text = "\"\(quote.text)\" - \(quote.author)"
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let activityVC = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        
        window.rootViewController?.present(activityVC, animated: true)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy - HH:mm"
        return formatter
    }
}
