//
//  StockRepositoryProtocol.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

protocol StockRepositoryProtocol {
    func startPriceFeed()
    func stopPriceFeed()
    func observeStocks() -> AsyncStream<[Stock]>
    func observeConnection() -> AsyncStream<ConnectionState>

}
