//
//  FavoritesView.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// Экран "Избранное" (Favorites)

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Favorites")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                if favoritesManager.favorites.isEmpty {
                    Spacer()
                    Text("No favorites yet")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(favoritesManager.favorites) { quote in
                                FavoriteQuoteCard(quote: quote)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 60) // Отступ для TabBar
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}
