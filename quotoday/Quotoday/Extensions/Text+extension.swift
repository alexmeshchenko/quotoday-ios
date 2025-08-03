//
//  Text+extension.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import SwiftUI

extension Text {
    static func highlight(_ string: String, matching search: String) -> Text {
        guard !search.isEmpty else { return Text(string) }

        var result = Text("")
        var currentIndex = string.startIndex
        let lowercasedString = string.lowercased()
        let lowercasedSearch = search.lowercased()

        while let range = lowercasedString.range(of: lowercasedSearch, options: [], range: currentIndex..<lowercasedString.endIndex) {
            // Добавляем часть до совпадения
            let prefix = string[currentIndex..<range.lowerBound]
            result = result + Text(prefix)

            // Добавляем выделенное совпадение
            let match = string[range]
            result = result + Text(match).foregroundColor(.blue)

            // Продвигаем указатель
            currentIndex = range.upperBound
        }

        // Добавляем оставшийся текст
        if currentIndex < string.endIndex {
            let suffix = string[currentIndex..<string.endIndex]
            result = result + Text(suffix)
        }

        return result
    }
}
