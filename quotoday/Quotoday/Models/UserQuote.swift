//
//  UserQuote.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import Foundation

// Модель для пользовательских цитат
struct UserQuote: Identifiable, Codable {
    let id: UUID
    let text: String
    let author: String
    let createdAt: Date
    var isBookmarked: Bool = false
    
    // Кастомный инициализатор для создания новых цитат
        init(text: String, author: String, createdAt: Date = Date(), isBookmarked: Bool = false) {
            self.id = UUID()
            self.text = text
            self.author = author
            self.createdAt = createdAt
            self.isBookmarked = isBookmarked
        }
    
    // CodingKeys для правильной работы Codable с let id = UUID()
    enum CodingKeys: String, CodingKey {
        case id, text, author, createdAt, isBookmarked
    }
}
