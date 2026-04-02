//
//  StockDetailView.swift
//  StockTracker
//
//  Created by Laksh Purbey on 02/04/26.
//

import SwiftUI

struct StockDetailView: View {
    
    @StateObject private var viewModel: StockDetailViewModel
    
    init(symbol: String, repository: StockRepositoryProtocol) {
        _viewModel = StateObject(
            wrappedValue: StockDetailViewModel(
                symbol: symbol,
                repository: repository
            )
        )
    }
    
    var body: some View {
        ZStack {
            
            // Background
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                headerView
                
                priceCard
                
                descriptionCard
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(viewModel.stock?.symbol ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
        
}

//MARK:  -  HeaderView

private extension StockDetailView {
    
    var headerView: some View {
        HStack {
            
            Text(viewModel.stock?.symbol ?? "--")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            HStack(spacing: 6) {
                Circle()
                    .fill(viewModel.isConnected ? Color.green : Color.red)
                    .frame(width: 8, height: 8)
                
                Text(viewModel.isConnected ? "Live" : "Offline")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

private extension StockDetailView {
    
    var priceCard: some View {
        VStack(spacing: 16) {
            
            if let stock = viewModel.stock {
                
                Text(stock.price.toPriceString())
                    .font(.system(size: 42, weight: .bold))
                    .monospacedDigit()
                
                HStack(spacing: 8) {
                    
                    Image(systemName: stock.change >= 0 ? "arrow.up.right" : "arrow.down.right")
                    
                    Text(stock.change.toChangeString())
                        .fontWeight(.semibold)
                }
                .foregroundColor(.stockChangeColor(stock.change))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.stockChangeColor(stock.change).opacity(0.15))
                )
                .animation(.easeInOut, value: stock.price)
                
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
        )
    }
}


private extension StockDetailView {
    
    var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("About")
                .font(.headline)
            
            Text(descriptionText)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
        )
    }
    
    var descriptionText: String {
        "This stock represents \(viewModel.stock?.symbol ?? ""). Prices are updated in real-time using a WebSocket connection. This module is designed to scale for real trading applications."
    }
}
