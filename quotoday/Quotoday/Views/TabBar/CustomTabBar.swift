//
//  CustomTabBar.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            tabItem(.favorites, systemImage: "bookmark.fill")
            Spacer()
            tabItem(.home, systemImage: "house.fill")
            Spacer()
            tabItem(.myQuotes, systemImage: "square.and.pencil")
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .padding(.horizontal, 16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2)
    }

    private func tabItem(_ tab: Tab, systemImage: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            Image(systemName: systemImage)
                .font(.system(size: 18, weight: .semibold))
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(selectedTab == tab ? Color.appGreen : Color.clear)
                )
                .foregroundColor(.primary)
        }
    }
}
