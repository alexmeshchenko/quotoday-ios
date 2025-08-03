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
    case invalidCategory
    
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Incorrect API key. Check the settings."
        case .rateLimitExceeded:
            return "Request limit exceeded. Try again later."
        case .serverError(let code):
            return "Server Fault (code: \(code))"
        case .decodingFailed:
            return "Failed to process server response"
        case .noQuotesFound:
            return "Quotes not found"
        case .invalidURL:
            return "Incorrect request URL"
        case .invalidCategory:
            return "Unsupported category"
        }
    }
}
