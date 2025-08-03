//
//  APIQuote.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//


import Foundation

// MARK: - API Response Model
struct APIQuote: Codable {
    let quote: String
    let author: String
    let category: String
}