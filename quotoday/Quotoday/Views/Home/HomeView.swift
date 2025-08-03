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
                    HomeLoadingView()
                } else if let error = viewModel.errorMessage {
                    HomeErrorView(
                        errorMessage: error,
                        onRetry: {
                            Task {
                                await viewModel.loadQuotes()
                            }
                        }
                    )
                } else {
                    HomeContentView(
                        favoritesManager: favoritesManager, quotes: viewModel.quotes,
                        onRefresh: viewModel.refreshQuote
                    )
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
                    selectedThemes: viewModel.selectedThemes,
                    onSave: { newThemes in
                        viewModel.saveSelectedThemes(newThemes)
                    }
                )
            }
            
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FavoritesManager())
    }
}
