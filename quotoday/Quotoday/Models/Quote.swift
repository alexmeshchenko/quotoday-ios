//
//  Quote.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import Foundation

// Базовая модель цитаты

struct Quote: Codable, Identifiable {
    var id = UUID()
    let text: String
    let author: String
    let category: String
    
    // Для сравнения цитат (нужно для Equatable)
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        lhs.id == rhs.id
    }
}
