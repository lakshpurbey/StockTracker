//
//  StockListView.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

import SwiftUI

struct StockListView: View {
    
    @StateObject var viewModel: StockListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.stocks) { stock in
                NavigationLink(destination: StockDetailView(
                    symbol: stock.symbol,
                    repository: viewModel.repository
                )) {
                    StockRowView(stock: stock)
                }
            }
            .navigationTitle("Stock Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.isConnected ? viewModel.stop() : viewModel.start()
                    }) {
                        HStack(spacing: 8) {
                            
                            Circle()
                                .fill(viewModel.isConnected ? Color.green : Color.gray)
                                .frame(width: 10, height: 10)
                            
                            Text(viewModel.isConnected ? "Stop" : "Start")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color(.systemGray6))
                        )
                    }
                    .animation(.easeInOut, value: viewModel.isConnected)
                }
            }        }
    }
}
