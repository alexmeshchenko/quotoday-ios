//
//  Category.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import Foundation

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String? // для эмодзи или SF Symbol
}
