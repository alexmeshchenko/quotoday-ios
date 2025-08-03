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
                    
                    if viewModel.userQuotes.isEmpty {
                        // Пустое состояние
                        VStack(spacing: 16) {
                            Spacer()
                            Image(systemName: "quote.bubble")
                                .font(.system(size: 60))
                                .foregroundColor(.secondary)
                            
                            Text("No quotes")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Press '+' to add your first quote")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.userQuotes) { quote in
                                    UserQuoteCard(quote: quote, viewModel: viewModel)
                                        .transition(.asymmetric(
                                            insertion: .move(edge: .trailing).combined(with: .opacity),
                                            removal: .move(edge: .leading).combined(with: .opacity)
                                        ))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 70) // Отступ для TabBar
                            .animation(.spring(response: 0.3), value: viewModel.userQuotes.count)
                        }
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
                                .shadow(radius: 4)
                        }
                        .padding(.bottom, 80)
                        .padding(.trailing, 10)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showAddQuote) {
                AddQuoteView(viewModel: viewModel)
            }
        }
    }
}
