//
//  QuotesViewModel.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import Foundation

@MainActor
class QuotesViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var categories: [Category] = []
    @Published var searchText = ""
    @Published var selectedCategory: Category?
    
    func loadQuotes() async {
        // Загрузка цитат
    }
    
    var filteredQuotes: [Quote] {
        // Фильтрация по поиску
        return []
    }
}
