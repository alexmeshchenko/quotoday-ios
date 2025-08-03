//
//  HomeContentView.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import SwiftUI

// MARK: - Content View
struct HomeContentView: View {
    @ObservedObject var favoritesManager: FavoritesManager
    let quotes: [Quote]
    let onRefresh: (Int) async -> Void
    
    var body: some View {
        ScrollView {
            if quotes.isEmpty {
                EmptyQuotesView()
                    .padding(.top, 100)
            } else {
                LazyVStack(spacing: 20) {
                    ForEach(Array(quotes.enumerated()), id: \.element.id) { index, quote in
                        QuoteCard(
                            quote: quote,
                            isBookmarked: favoritesManager.isFavorite(quote),
                            onBookmarkToggle: {
                                withAnimation(.spring(response: 0.3)) {
                                    favoritesManager.toggleFavorite(quote)
                                }
                            },
                            onRefresh: {
                                Task {
                                    await onRefresh(index)
                                }
                            }
                        )
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 70) // Отступ для TabBar
            }
        }
    }
}
