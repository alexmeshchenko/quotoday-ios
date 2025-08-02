//
//  MyQuotesViewModel.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//


import SwiftUI
import Combine

// MyQuotesViewModel
// вью-модель с логикой:
// * Загрузка/сохранение цитат в UserDefaults
// * Добавление новых цитат
// * Управление закладками
// * Удаление цитат

class MyQuotesViewModel: ObservableObject {
    @Published var userQuotes: [UserQuote] = []
    
    private let userDefaults = UserDefaults.standard
    private let userQuotesKey = "userQuotes"
    
    init() {
        loadQuotes()
    }
    
    // Загрузка цитат из UserDefaults (для начала, потом можно перейти на Core Data)
    func loadQuotes() {
        if let data = userDefaults.data(forKey: userQuotesKey),
           let quotes = try? JSONDecoder().decode([UserQuote].self, from: data) {
            self.userQuotes = quotes.sorted { $0.createdAt > $1.createdAt }
        }
    }
    
    // Сохранение цитат
    func saveQuotes() {
        if let data = try? JSONEncoder().encode(userQuotes) {
            userDefaults.set(data, forKey: userQuotesKey)
        }
    }
    
    // Добавление новой цитаты
    func addQuote(text: String, author: String) {
        let newQuote = UserQuote(
            text: text,
            author: author,
            createdAt: Date(),
            isBookmarked: false
        )
        userQuotes.insert(newQuote, at: 0)
        saveQuotes()
    }
    
    // Удаление цитаты
    func deleteQuote(at offsets: IndexSet) {
        userQuotes.remove(atOffsets: offsets)
        saveQuotes()
    }
    
    // Переключение закладки
    func toggleBookmark(for quote: UserQuote) {
        if let index = userQuotes.firstIndex(where: { $0.id == quote.id }) {
            userQuotes[index].isBookmarked.toggle()
            saveQuotes()
        }
    }
}
