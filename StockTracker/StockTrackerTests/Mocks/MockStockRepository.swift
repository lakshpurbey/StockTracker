//
//  MockStockRepository.swift
//  StockTracker
//
//  Created by Laksh Purbey on 02/04/26.
//

import Foundation
@testable import StockTracker

final class MockStockRepository: StockRepositoryProtocol {
    
    var stocks: [Stock] = []
    var connection: ConnectionState = .disconnected
    
    private var stockContinuation: AsyncStream<[Stock]>.Continuation?
    private var connectionContinuation: AsyncStream<ConnectionState>.Continuation?
    
    func startPriceFeed() {}
    func stopPriceFeed() {}
    
    func observeStocks() -> AsyncStream<[Stock]> {
        AsyncStream { continuation in
            self.stockContinuation = continuation
            continuation.yield(stocks)
        }
    }
    
    func observeConnection() -> AsyncStream<ConnectionState> {
        AsyncStream { continuation in
            self.connectionContinuation = continuation
            continuation.yield(connection)
        }
    }
    
    // MARK:  -  Helpers  -
    
    func sendStocks(_ stocks: [Stock]) {
        stockContinuation?.yield(stocks)
    }
    
    func sendConnection(_ state: ConnectionState) {
        connectionContinuation?.yield(state)
    }
}
