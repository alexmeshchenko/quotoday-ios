//
//  FavoriteQuoteCard.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// Карточка для избранного (с зеленой меткой)

// MARK: - FavoriteQuoteCard
struct FavoriteQuoteCard: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    let quote: Quote
    @State private var showShareSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(quote.text)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            Text("- \(quote.author)")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            HStack {
                
                // Зеленая метка избранного
                Image(systemName: "bookmark.fill")
                    .font(.system(size: 22))
                    .foregroundColor(Color.appGreen)
                
                Spacer()
                
                Button(action: {
                    showShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.primary)
                }
            }
            
            Text(Date(), style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
        .contextMenu {
            Button(action: {
                favoritesManager.removeFromFavorites(quote)
            }) {
                Label("Remove from favorites", systemImage: "bookmark")
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: ["\"\(quote.text)\" - \(quote.author)"])
        }
    }
}
