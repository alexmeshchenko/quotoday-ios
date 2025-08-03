//
//  HomeLoadingView.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import SwiftUI

// MARK: - Loading View
struct HomeLoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(2)
                .tint(.appGreen)
            Text("Upload quotes...")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 20)
            Spacer()
        }
    }
}
