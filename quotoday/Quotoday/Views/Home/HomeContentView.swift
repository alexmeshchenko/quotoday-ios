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
    
    @State private var searchText: String = ""
    
    // Фильтрация цитат по поисковому тексту
    private var filteredQuotes: [Quote] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return quotes
        } else {
            return quotes.filter {
                $0.text.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Поисковая строка
                SearchBar(text: $searchText)
                
                if quotes.isEmpty {
                    EmptyQuotesView()
                        .padding(.top, 100)
                } else {
                    LazyVStack(spacing: 20) {
                        ForEach(Array(filteredQuotes.enumerated()), id: \.element.id) { index, quote in
                            QuoteCard(
                                quote: quote,
                                searchText: searchText,
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
                } // else
            }
            .padding(.top)
        }
    }
}
