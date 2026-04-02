//
//  MockWebSocketService.swift
//  StockTracker
//
//  Created by Laksh Purbey on 02/04/26.
//

import Foundation
@testable import StockTracker

final class MockWebSocketService: WebSocketServiceProtocol {
    
    private var messageContinuation: AsyncStream<String>.Continuation?
    private var stateContinuation: AsyncStream<ConnectionState>.Continuation?
    
    var messages: AsyncStream<String> {
        AsyncStream { continuation in
            self.messageContinuation = continuation
        }
    }
    
    var connectionState: AsyncStream<ConnectionState> {
        AsyncStream { continuation in
            self.stateContinuation = continuation
        }
    }
    
    func connect() {
        stateContinuation?.yield(.connected)
    }
    
    func disconnect() {
        stateContinuation?.yield(.disconnected)
    }
    
    func send(message: String) {
        messageContinuation?.yield(message)
    }
        
    func simulateMessage(_ message: String) {
        messageContinuation?.yield(message)
    }
    
    func simulateConnection(_ state: ConnectionState) {
        stateContinuation?.yield(state)
    }
}
