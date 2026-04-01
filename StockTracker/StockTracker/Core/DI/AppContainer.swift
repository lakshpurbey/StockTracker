//
//  AppContainer.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//


import Foundation

final class AppContainer {
    
    // MARK:  -  Services  -
    
    lazy var webSocketService: WebSocketServiceProtocol = {
        WebSocketService()
    }()
    
    // MARK:  -  Repositories
    
    lazy var stockRepository: StockRepositoryProtocol = {
        StockRepository(socket: webSocketService)
    }()
    
    // MARK:  -  ViewModels  -
    
    func makeStockListViewModel() -> StockListViewModel {
        StockListViewModel(repository: stockRepository)
    }
    
}
