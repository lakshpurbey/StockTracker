//
//  StockDetailViewModelTests.swift
//  StockTracker
//
//  Created by Laksh Purbey on 02/04/26.
//

import XCTest
@testable import StockTracker

@MainActor
final class StockDetailViewModelTests: XCTestCase {
    
    private var viewModel: StockDetailViewModel!
    private var mockRepo: MockStockRepository!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockStockRepository()
        
        viewModel = StockDetailViewModel(
            symbol: "AAPL",
            repository: mockRepo
        )
    }
    
    func test_stockUpdatesCorrectly() async {
        
        let expectation = expectation(description: "Stock updates")
        
        let stock = Stock(id: "AAPL", symbol: "AAPL", price: 150, change: 5)
        
        Task {
            mockRepo.sendStocks([stock])
            
            try? await Task.sleep(nanoseconds: 500_000_000)
            
            XCTAssertEqual(self.viewModel.stock?.symbol, "AAPL")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_connectionUpdates() async {
        
        let expectation = expectation(description: "Connection updates")
        
        Task {
            mockRepo.sendConnection(.connected)
            
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            XCTAssertTrue(self.viewModel.isConnected)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2)
    }
}
