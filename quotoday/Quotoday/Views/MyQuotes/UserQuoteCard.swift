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
    @ObservedObject var viewModel: MyQuotesViewModel
    @State private var isBookmarked: Bool
    @State private var offset: CGFloat = 0
    @State private var isSwiped = false
    
    init(quote: UserQuote, viewModel: MyQuotesViewModel) {
        self.quote = quote
        self.viewModel = viewModel
        self._isBookmarked = State(initialValue: quote.isBookmarked)
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Фон для удаления
            DeleteBackgroundView(
                onDelete: {
                    deleteQuote()
                }
            )
            
            // Основная карточка
            QuoteCardContent(
                quote: quote,
                viewModel: viewModel
            )
            .background(Color(UIColor.systemBackground)) // Добавляем непрозрачный фон
            .cornerRadius(12)
            .offset(x: offset)
            .gesture(swipeGesture)
        }
    }
    
    // MARK: - Gesture
    private var swipeGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width < 0 {
                    offset = value.translation.width
                }
            }
            .onEnded { value in
                withAnimation(.spring()) {
                    if value.translation.width < -100 {
                        offset = -80
                        isSwiped = true
                    } else {
                        offset = 0
                        isSwiped = false
                    }
                }
            }
    }
    
    // MARK: - Delete Action
    private func deleteQuote() {
        withAnimation(.easeOut(duration: 0.3)) {
            offset = -UIScreen.main.bounds.width
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            viewModel.deleteQuote(quote)
        }
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
