//
//  HomeView.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// Экран "Главный"

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var showCategories = false
    
    var body: some View {
        NavigationView {
            Group {
                // Контент
                if viewModel.isLoading {
                    VStack {
                         Spacer()
                         ProgressView()
                             .scaleEffect(1.5)
                         Spacer()
                     }
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Spacer()
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text(error)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        Button("Попробовать снова") {
                            Task {
                                await viewModel.loadQuotes()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.appGreen)
                        Spacer()
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(Array(viewModel.quotes.enumerated()), id: \.element.id) { index, quote in
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
                                            await viewModel.refreshQuote(at: index)
                                        }
                                    }
                                )
                                .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.quotodayLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 32)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showCategories = true }) {
                        Image(systemName: "square.grid.2x2")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showCategories) {
                CategoriesView(
                    selectedCategories: viewModel.selectedCategories,
                    onSave: { categories in
                        viewModel.saveSelectedCategories(categories)
                    }
                )
            }
            
        }
    }
}
