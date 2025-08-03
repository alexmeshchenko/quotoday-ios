//
//  MyQuotesView.swift
//  quotoday
//
//  Created by Aleksandr Meshchenko on 02.08.25.
//

import SwiftUI

// Экран "Свои цитаты" (Post a Quote)
struct MyQuotesView: View {
    @StateObject private var viewModel = MyQuotesViewModel()
    @State private var showAddQuote = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Post a Quote")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.userQuotes) { quote in
                                UserQuoteCard(quote: quote)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Плавающая кнопка "+"
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showAddQuote = true }) {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 60, height: 60)
                                .background(Color.appGreen)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .padding()
                    }
                }
            }
            .padding(.bottom, 70) // Отступ для TabBar
            .navigationBarHidden(true)
            .sheet(isPresented: $showAddQuote) {
                AddQuoteView()
            }
        }
    }
}
