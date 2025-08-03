//
//  Color+extensions.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// Цветовая схема
extension Color {
    // Основной зеленый #C4E538
    static let appGreen = Color(hex: "C2FF40")
    
    // Фон карточек на главной #E8F5B7 (светло-желтый)
    static let appYellow = Color(hex: "F6FF7D")
    
    // Фон для остальных карточек: светло-серый
    static let cardBackground = Color.yellow.opacity(0.15)
}
