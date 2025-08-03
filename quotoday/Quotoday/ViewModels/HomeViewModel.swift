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
    @Published var selectedThemes: Set<QuoteTheme> = []
    
    private var cancellables = Set<AnyCancellable>()
    private let quotesService = QuotesService.shared
    
    init() {
        // Загружаем выбранные категории из UserDefaults
        loadSelectedThemes()
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
            if !selectedThemes.isEmpty {
                let categories = Set(selectedThemes.flatMap { $0.categories })
                // Загружаем цитаты из выбранных категорий
                self.quotes = try await quotesService.fetchQuotes(
                    categories: categories,
                    count: min(selectedThemes.count, 3) // Максимум 3 цитаты
                )
            } else {
                // Загружаем случайные цитаты
                self.quotes = try await quotesService.fetchRandomQuotes(count: 2)
            }
        } catch {
            errorMessage = "Could not load quotes: \(error.localizedDescription)"
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
    
    // Сохранение выбранных тем
    func saveSelectedThemes(_ themes: Set<QuoteTheme>) {
        selectedThemes = themes
        
        // Сохраняем как массив строк
        let rawValues = Array(themes.map(\.rawValue))
        UserDefaults.standard.set(rawValues, forKey: "selectedThemes")
        
        Task {
            await loadQuotes()
        }
    }
    
    // Загрузка выбранных тем
    private func loadSelectedThemes() {
        if let rawValues = UserDefaults.standard.array(forKey: "selectedThemes") as? [String] {
            let themes = rawValues.compactMap { QuoteTheme(rawValue: $0) }
            selectedThemes = Set(themes)
        }
    }
}
