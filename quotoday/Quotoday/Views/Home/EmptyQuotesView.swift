//
//  EmptyQuotesView.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import SwiftUI

// MARK: - Empty State View
struct EmptyQuotesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "quote.bubble")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("Нет цитат для отображения")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Выберите категории, чтобы увидеть вдохновляющие цитаты")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 40)
        }
    }
}
