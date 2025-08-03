//
//  ContentView.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var favoritesManager = FavoritesManager()
    @StateObject private var myQuotesViewModel = MyQuotesViewModel()
    @State private var selectedTab: Tab = .home

    var body: some View {
            ZStack {
                Group {
                    switch selectedTab {
                    case .favorites:
                        FavoritesView()
                    case .home:
                        HomeView()
                    case .myQuotes:
                        MyQuotesView()
                            .environmentObject(myQuotesViewModel)
                    }
                }
                .environmentObject(favoritesManager)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
}

#Preview {
    ContentView()
}
