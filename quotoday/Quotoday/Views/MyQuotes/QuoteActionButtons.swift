//
//  QuoteActionButtons.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import SwiftUI

struct QuoteActionButtons: View {
    @Binding var isBookmarked: Bool
    let onBookmarkToggle: () -> Void
    let onShare: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                isBookmarked.toggle()
                onBookmarkToggle()
            }) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(isBookmarked ? .yellow : .gray)
            }
            
            Spacer()
            
            Button(action: onShare) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.blue)
            }
        }
    }
}
