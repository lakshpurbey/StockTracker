//
//  StockListViewModel.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

import Foundation
import Combine

@MainActor
final class StockListViewModel: ObservableObject {
    
    @Published var stocks: [Stock] = []
    @Published var isConnected: Bool = false
    
    let repository: StockRepositoryProtocol
    private var observeTask: Task<Void, Never>?

    
    init(repository: StockRepositoryProtocol) {
        self.repository = repository
        
        // Start immediately
        isConnected = true
        repository.startPriceFeed()

        observeTask = Task {
            for await stocks in repository.observeStocks() {
                self.stocks = stocks
            }
        }
    }
    
    func start() {
        isConnected = true
        repository.startPriceFeed()
        
        Task {
            for await stocks in repository.observeStocks() {
                self.stocks = stocks
            }
        }
    }
    
    func stop() {
        isConnected = false
        repository.stopPriceFeed()
    }
    
    func sortByPrice() {
        stocks.sort { $0.price > $1.price }
    }
    
    func sortByChange() {
        stocks.sort { $0.change > $1.change }
    }
}
