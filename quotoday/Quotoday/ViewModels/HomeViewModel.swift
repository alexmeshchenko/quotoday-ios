//
//  HomeViewModel.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

// MARK: - HomeViewModel
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedCategories: Set<String> = []
    
    private var cancellables = Set<AnyCancellable>()
    private let quotesService = QuotesService.shared
    
    init() {
        // Загружаем выбранные категории из UserDefaults
        loadSelectedCategories()
        // Загружаем начальные цитаты
        Task {
            await loadQuotes()
        }
    }
    
    // Загрузка цитат
    @MainActor
    func loadQuotes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Если есть выбранные категории, загружаем по ним
            if !selectedCategories.isEmpty {
                // Загружаем по одной цитате для каждой категории
                var allQuotes: [Quote] = []
                for category in selectedCategories {
                    if let quote = try await quotesService.fetchQuote(category: category) {
                        allQuotes.append(quote)
                    }
                }
                self.quotes = allQuotes
            } else {
                // Загружаем случайные цитаты
                self.quotes = try await quotesService.fetchRandomQuotes(count: 2)
            }
        } catch {
            errorMessage = "Не удалось загрузить цитаты: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    // Обновление конкретной цитаты
    @MainActor
    func refreshQuote(at index: Int) async {
        guard quotes.indices.contains(index) else { return }
        
        do {
            let category = quotes[index].category
            if let newQuote = try await quotesService.fetchQuote(category: category) {
                quotes[index] = newQuote
            }
        } catch {
            print("Ошибка обновления цитаты: \(error)")
        }
    }
    
    // Сохранение выбранных категорий
    func saveSelectedCategories(_ categories: Set<String>) {
        selectedCategories = categories
        UserDefaults.standard.set(Array(categories), forKey: "selectedCategories")
        
        // Перезагружаем цитаты с новыми категориями
        Task {
            await loadQuotes()
        }
    }
    
    // Загрузка выбранных категорий
    private func loadSelectedCategories() {
        if let savedCategories = UserDefaults.standard.array(forKey: "selectedCategories") as? [String] {
            selectedCategories = Set(savedCategories)
        }
    }
}
