//
//  QuotesService.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

//class QuotesService {
//    static let shared = QuotesService()
//    private let baseURL = "https://api-ninjas.com/api/quotes"
//    
//    func fetchQuotes(category: String? = nil) async throws -> [Quote] {
//        // Реализация запроса к API
//        return []
//    }
//}

// MARK: - QuotesService (заглушка для API)
class QuotesService {
    static let shared = QuotesService()
    
    private init() {}
    
    // Временные данные для демонстрации
    private let sampleQuotes = [
        Quote(text: "The best way to spread Christmas cheer is singing loud for all to hear.",
              author: "Buddy the Elf",
              category: "happiness"),
        Quote(text: "Success is not final, failure is not fatal: it is the courage to continue that counts.",
              author: "Winston Churchill",
              category: "courage"),
        Quote(text: "The only way to do great work is to love what you do.",
              author: "Steve Jobs",
              category: "work"),
        Quote(text: "In the middle of difficulty lies opportunity.",
              author: "Albert Einstein",
              category: "opportunity")
    ]
    
    func fetchRandomQuotes(count: Int) async throws -> [Quote] {
        // Имитация задержки сети
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // Возвращаем случайные цитаты
        return Array(sampleQuotes.shuffled().prefix(count))
    }
    
    func fetchQuote(category: String) async throws -> Quote? {
        // Имитация задержки сети
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // Возвращаем случайную цитату из категории
        return sampleQuotes.randomElement()
    }
}
