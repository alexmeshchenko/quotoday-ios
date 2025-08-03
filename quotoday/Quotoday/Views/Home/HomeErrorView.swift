//
//  HomeErrorView.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import SwiftUI

// MARK: - Error View
struct HomeErrorView: View {
    let errorMessage: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("Упс! Что-то пошло не так")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(errorMessage)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 40)
            
            Button(action: onRetry) {
                Label("Попробовать снова", systemImage: "arrow.clockwise")
                    .font(.system(size: 16, weight: .medium))
            }
            .buttonStyle(.borderedProminent)
            .tint(.appGreen)
            .padding(.top, 8)
            
            Spacer()
        }
        .padding()
    }
}
