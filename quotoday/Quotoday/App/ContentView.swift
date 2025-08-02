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
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {

            FavoritesView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                        .renderingMode(.template)
                }
                .tag(0)
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                        .renderingMode(.template)
                }
                .tag(1)

            MyQuotesView()
                .environmentObject(myQuotesViewModel)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                        .renderingMode(.template)
                }
                .tag(2)
        }
        .accentColor(.appGreen)// Зеленый цвет для выбранной вкладки
        .environmentObject(favoritesManager)
    }
}

#Preview {
    ContentView()
}
