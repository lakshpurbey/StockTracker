//
//  StockRepositoryTests.swift
//  StockTracker
//
//  Created by Laksh Purbey on 02/04/26.
//

import XCTest
@testable import StockTracker

final class StockRepositoryTests: XCTestCase {
    
    private var repository: StockRepository!
    private var mockSocket: MockWebSocketService!
    
    override func setUp() {
        super.setUp()
        mockSocket = MockWebSocketService()
        repository = StockRepository(socket: mockSocket)
    }
    
    func test_observeStocks_emitsInitialData() async {
        
        let expectation = expectation(description: "Receive initial stocks")
        
        Task {
            var iterator = await repository.observeStocks().makeAsyncIterator()
            let stocks = await iterator.next()
            
            XCTAssertNotNil(stocks)
            XCTAssertEqual(stocks?.count, 25)
            
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_connectionState_updatesCorrectly() async {
        
        let expectation = expectation(description: "Connection state updates")
        
        Task {
            var iterator = await repository.observeConnection().makeAsyncIterator()
            
            mockSocket.simulateConnection(.connected)
            
            let state = await iterator.next()
            XCTAssertEqual(state, .connected)
            
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2)
    }
}
