//
//  ObserveStocksUseCase.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

final class ObserveStocksUseCase {
    private let repository: StockRepositoryProtocol
    
    init(repository: StockRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AsyncStream<[Stock]> {
        repository.observeStocks()
    }
}
