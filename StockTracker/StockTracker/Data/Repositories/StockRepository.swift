//
//  StockRepository.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

final class StockRepository: StockRepositoryProtocol {
    
    private let socket: WebSocketServiceProtocol
    private var stocks: [Stock] = []
    private var continuation: AsyncStream<[Stock]>.Continuation?
    
    init(socket: WebSocketServiceProtocol) {
        self.socket = socket
        self.stocks = Self.generateInitialStocks()
    }
    
    func startPriceFeed() {
        socket.connect()
        
        Task {
            for await _ in socket.messages {
                updatePrices()
                continuation?.yield(stocks)
            }
        }
        
        sendRandomUpdates()
    }
    
    func stopPriceFeed() {
        socket.disconnect()
    }
    
    func observeStocks() -> AsyncStream<[Stock]> {
        AsyncStream { continuation in
            self.continuation = continuation
            continuation.yield(stocks)
        }
    }
    
    private func sendRandomUpdates() {
        Task {
            while true {
                let randomPrice = Double.random(in: 100...500)
                socket.send(message: "\(randomPrice)")
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
        }
    }
    
    private func updatePrices() {
        stocks = stocks.map {
            var stock = $0
            let newPrice = Double.random(in: 100...500)
            stock.change = newPrice - stock.price
            stock.price = newPrice
            return stock
        }
    }
    
    private static func generateInitialStocks() -> [Stock] {
        let symbols = ["AAPL","GOOG","TSLA","AMZN","MSFT","NVDA","META","NFLX","AMD","INTC",
                       "BABA","ORCL","IBM","SAP","ADBE","CRM","PYPL","UBER","LYFT","TWTR",
                       "SHOP","SQ","SONY","DELL","HPQ"]
        
        return symbols.map {
            Stock(id: $0, symbol: $0, price: Double.random(in: 100...500), change: 0)
        }
    }
}
