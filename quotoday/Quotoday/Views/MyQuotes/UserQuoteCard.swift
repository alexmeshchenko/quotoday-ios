//
//  UserQuoteCard.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// UserQuoteCard
// - карточка для отображения цитаты с:
// * Кнопкой закладки
// * Кнопкой "поделиться"
// * Датой создания

// MARK: - Views
struct UserQuoteCard: View {
    let quote: UserQuote
    @State private var isBookmarked: Bool
    @EnvironmentObject var viewModel: MyQuotesViewModel
    
    init(quote: UserQuote) {
        self.quote = quote
        self._isBookmarked = State(initialValue: quote.isBookmarked)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(quote.text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            
            Text("- \(quote.author)")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            HStack {
                Button(action: {
                    isBookmarked.toggle()
                    viewModel.toggleBookmark(for: quote)
                }) {
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
            Text(quote.createdAt, formatter: dateFormatter)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 2)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    func shareQuote() {
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
