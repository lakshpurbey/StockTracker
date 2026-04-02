//
//  Untitled.swift
//  StockTracker
//
//  Created by Laksh Purbey on 02/04/26.
//

import Combine

@MainActor
final class StockDetailViewModel: ObservableObject {
    
    @Published var stock: Stock?
    @Published var isConnected: Bool = false

    private let repository: StockRepositoryProtocol
    private let symbol: String
    
    init(symbol: String, repository: StockRepositoryProtocol) {
        self.symbol = symbol
        self.repository = repository
        observe()
        observeConnection()

    }
    
    private func observe() {
        Task {
            for await stocks in repository.observeStocks() {
                self.stock = stocks.first { $0.symbol == symbol }
            }
        }
    }
    
    private func observeConnection() {
          Task {
              for await state in repository.observeConnection() {
                  self.isConnected = (state == .connected)
              }
          }
      }
}
