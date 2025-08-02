//
//  FavoritesManager.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI
import Combine

class FavoritesManager: ObservableObject {
    @Published var favorites: [Quote] = []
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favoriteQuotes"
    
    init() {
        loadFavorites()
    }
    
    // Загрузка избранных из UserDefaults
    func loadFavorites() {
        if let data = userDefaults.data(forKey: favoritesKey),
           let quotes = try? JSONDecoder().decode([Quote].self, from: data) {
            self.favorites = quotes
        }
    }
    
    // Сохранение избранных
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            userDefaults.set(data, forKey: favoritesKey)
        }
    }
    
    // Добавление в избранное
    func addToFavorites(_ quote: Quote) {
        // Проверяем, что цитата еще не добавлена
        guard !favorites.contains(where: { $0.id == quote.id }) else { return }
        favorites.append(quote)
        saveFavorites()
    }
    
    // Удаление из избранного
    func removeFromFavorites(_ quote: Quote) {
        favorites.removeAll { $0.id == quote.id }
        saveFavorites()
    }
    
    // Проверка, находится ли цитата в избранном
    func isFavorite(_ quote: Quote) -> Bool {
        favorites.contains { $0.id == quote.id }
    }
    
    // Переключение статуса избранного
    func toggleFavorite(_ quote: Quote) {
        if isFavorite(quote) {
            removeFromFavorites(quote)
        } else {
            addToFavorites(quote)
        }
    }
}
