//
//  QuotesService.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import Foundation

// MARK: - QuotesService
class QuotesService {
    static let shared = QuotesService()
    
    private let baseURL = "https://api.api-ninjas.com/v1/quotes"
    private let apiKey: String
    private let session: URLSession
    
    private init() {
        // Получаем API ключ из Info.plist или Environment
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path),
           let key = config["API_NINJAS_KEY"] as? String {
            self.apiKey = key
        } else {
            // Для тестирования можно временно захардкодить ключ
            self.apiKey = "YOUR_API_KEY_HERE"
            print("Warning: Using hardcoded API key. Please add Config.plist with API_NINJAS_KEY")
        }
        
        // Настройка URLSession с таймаутом
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        self.session = URLSession(configuration: configuration)
    }
    
    // Получение случайных цитат из выбранных категорий
    func fetchQuotes(categories: Set<APICategory>, count: Int) async throws -> [Quote] {
        var quotes: [Quote] = []
        var attempts = 0
        let maxAttempts = count * 10 // Ограничиваем количество попыток
        
        // DEBUG: Покажем категории
         let categoryNames = categories.map(\.rawValue).joined(separator: ", ")
         print("➡️ Загрузка \(count) цитат из категорий: [\(categoryNames)]")

        while quotes.count < count && attempts < maxAttempts {
            attempts += 1
            
            do {
                // Получаем случайную цитату
                if let quote = try await fetchRandomQuote() {
                    print("🔍 Попытка \(attempts): \(quote.category) — \"\(quote.text.prefix(40))...\"")
                    
                    // Проверяем, подходит ли категория
                    if categories.isEmpty || categories.contains(where: { $0.rawValue == quote.category.lowercased() }) {
                        // Проверяем, нет ли уже такой цитаты
                        if !quotes.contains(where: { $0.text == quote.text }) {
                            print("✅ Добавлена цитата от \(quote.author)")
                            quotes.append(quote)
                        } else {
                            print("↩️ Пропущена повторяющаяся цитата")
                        }
                    } else {
                        print("⛔️ Категория не входит в список: \(quote.category)")
                    }
                }
            } catch {
                // Продолжаем попытки при ошибках
                print("Ошибка получения цитаты: \(error)")
            }
        }
        
        // Если не удалось получить нужное количество цитат
        if quotes.isEmpty {
            print("❌ Не удалось получить ни одной подходящей цитаты.")
            throw QuotesError.noQuotesFound
        }
        
        print("🎉 Загружено \(quotes.count) цитат после \(attempts) попыток.")
        return quotes
    }
    
    // Обновленный метод получения цитаты по категории (для бесплатного тарифа)
    func fetchQuote(category: String) async throws -> Quote? {
        // Если не нашли цитату нужной категории, возвращаем любую
        return try await fetchRandomQuote()
    }
    
    // Получение случайных цитат
    func fetchRandomQuotes(count: Int) async throws -> [Quote] {
        var quotes: [Quote] = []
        
        // API возвращает только одну цитату за раз, поэтому делаем несколько запросов
        await withTaskGroup(of: Quote?.self) { group in
            for _ in 0..<count {
                group.addTask {
                    try? await self.fetchRandomQuote()
                }
            }
            
            for await quote in group {
                if let quote = quote {
                    quotes.append(quote)
                }
            }
        }
        
        // Если не удалось загрузить нужное количество, добавляем из кэша или fallback
        if quotes.isEmpty {
            throw QuotesError.noQuotesFound
        }
        
        return quotes
    }
    
    // Получение случайной цитаты
    func fetchRandomQuote() async throws -> Quote? {
        let url = URL(string: baseURL)!
        let quote = try await performRequest(url: url)
        return quote
    }
    
    // Выполнение запроса
    private func performRequest(url: URL) async throws -> Quote? {
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        do {
            let (data, response) = try await session.data(for: request)
            
            // Проверяем статус ответа
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    break // Успешный ответ
                case 401:
                    throw QuotesError.unauthorized
                case 429:
                    throw QuotesError.rateLimitExceeded
                default:
                    throw QuotesError.serverError(statusCode: httpResponse.statusCode)
                }
            }
            
            // Декодируем ответ
            let apiQuotes = try JSONDecoder().decode([APIQuote].self, from: data)
            
            // Преобразуем в нашу модель
            return apiQuotes.first.map { apiQuote in
                Quote(
                    text: apiQuote.quote.trimmingCharacters(in: .whitespacesAndNewlines),
                    author: apiQuote.author.trimmingCharacters(in: .whitespacesAndNewlines),
                    category: apiQuote.category
                )
            }
            
        } catch let error as DecodingError {
            print("Decoding error: \(error)")
            throw QuotesError.decodingFailed
        } catch {
            print("Network error: \(error)")
            throw error
        }
    }
}

