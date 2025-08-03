//
//  QuotesError.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import Foundation

// MARK: - Errors
enum QuotesError: LocalizedError {
    case unauthorized
    case rateLimitExceeded
    case serverError(statusCode: Int)
    case decodingFailed
    case noQuotesFound
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Неверный API ключ. Проверьте настройки."
        case .rateLimitExceeded:
            return "Превышен лимит запросов. Попробуйте позже."
        case .serverError(let code):
            return "Ошибка сервера (код: \(code))"
        case .decodingFailed:
            return "Не удалось обработать ответ сервера"
        case .noQuotesFound:
            return "Цитаты не найдены"
        case .invalidURL:
            return "Неверный URL запроса"
        }
    }
}
