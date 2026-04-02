//
//  StockListViewModelTests.swift
//  StockTracker
//
//  Created by Laksh Purbey on 02/04/26.
//

import XCTest
@testable import StockTracker

@MainActor
final class StockListViewModelTests: XCTestCase {
    
    private var viewModel: StockListViewModel!
    private var mockRepo: MockStockRepository!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockStockRepository()
        viewModel = StockListViewModel(repository: mockRepo)
    }
    
    func test_start_updatesConnectionState() {
        viewModel.start()
        XCTAssertTrue(viewModel.isConnected)
    }
    
    func test_stop_updatesConnectionState() {
        viewModel.start()
        viewModel.stop()
        XCTAssertFalse(viewModel.isConnected)
    }
    
    func test_sortByPrice_sortsDescending() {
        
        viewModel.stocks = [
            Stock(id: "1", symbol: "A", price: 100, change: 1),
            Stock(id: "2", symbol: "B", price: 200, change: 2)
        ]
        
        viewModel.sortByPrice()
        
        XCTAssertEqual(viewModel.stocks.first?.price, 200)
    }
    
    func test_sortByChange_sortsDescending() {
        
        viewModel.stocks = [
            Stock(id: "1", symbol: "A", price: 100, change: 1),
            Stock(id: "2", symbol: "B", price: 200, change: 5)
        ]
        
        viewModel.sortByChange()
        
        XCTAssertEqual(viewModel.stocks.first?.change, 5)
    }
}
